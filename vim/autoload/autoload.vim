vim9script

const labels = [' ', 'f', 'j', 'd', 'l', 's', 'h', 'g', 'a', 'i', 'e', 'o', 'c', 'u']

def Message(text: string, color: string)
  redraw
  exe 'echohl StargateVIM9000'
  echo ' VIM9000 '
  exe $'echohl {color}'
  echon $' {text} '
  echohl None
enddef


def ErrorMessage(text: string)
  Message(text, 'StargateErrorMessage')
enddef


def StandardMessage(text: string)
  Message(text, 'StargateMessage')
enddef


def Error(message: string)
  def RemoveError(t: number)
    RemoveMatchHighlight(win['StargateError'])
    # redraw required, because while getchar() is active
    # the screen is not redrawn normally
    redraw
  enddef

  AddMatchHighlight('StargateError', 1002)
  ErrorMessage(message)
  timer_start(150, RemoveError)
enddef


def Warning(message: string)
  redraw
  echohl WarningMsg
  echom message
  echohl None
enddef

def BlankMessage()
  redraw
  echo ''
enddef

def Desaturate()
  AddMatchHighlight('StargateDesaturate', 1001)
enddef

def Designations(length: number): list<string>
  final ds = LabelLists(g:stargate_chars, length)

  var slice = ds.labels[ds.start_row : ds.end_row]
  const start = slice->remove(0)[ds.start_col :]
  const end = slice->insert(start)->remove(-1)[: ds.end_col]
  slice->add(end)

  # shuffle designations
  var dss = []
  for i in range(ds.len)
    for j in range(len(slice))
      const label = slice[j]->get(i, '')
      if !empty(label)
        dss->add(label)
      endif
    endfor
  endfor

  return dss
enddef

def OrbitalStars(pattern: string, flags: string, orbit: number): list<list<number>>
  cursor(orbit, 1)
  var stars: list<list<number>>
  var star = searchpos(pattern, flags, orbit)
  while star[0] != 0
    stars->add(star)
    const first = $'\%>{star[1]}c'
    star = searchpos(first .. pattern, flags, orbit)
  endwhile
  return stars
enddef

def CollectStars(orbits: list<number>, cur_loc: list<number>, pat: string): list<list<number>>
  var stars = []
  for orbit in orbits
    if strdisplaywidth(getline(orbit)) > max_col
      throw $'stargate: detected a line that is longer than {max_col}' ..
        ' characters. It can be slow, so plugin disabled.'
    endif

    var orbital_stars = OrbitalStars(pat, 'Wnc', orbit)
    if orbit == cur_loc[0]
      for i in range(len(orbital_stars))
        if orbital_stars[i][1] == cur_loc[1]
          orbital_stars->remove(i)
          break
        endif
      endfor
    endif
    stars->add(orbital_stars)
  endfor
  return stars->flattennew(1)
enddef

def GalaxyStars(pattern: string): list<list<number>>
  const arc = OrbitalArc()
  var degrees = {first: '', last: ''}
  if !&wrap
    degrees.first = $'\%>{arc.first - 1}v'
    degrees.last = $'\%<{arc.last + 1}v'
  endif

  const pat = degrees.first .. degrees.last .. pattern
  const cur_loc = [
    winview.lnum,
    winview.col + 1
  ]
  const stars = OrbitsWithoutBlackmatter(win.topline, win.botline)
           ->CollectStars(cur_loc, pat)

  winrestview(winview)
  return stars
enddef

def ChooseColor(prev: dict<any>, orbit: number, degree: number): string
  if orbit == prev.orbit
      && prev.len >= degree - prev.degree
      && prev.color == 'StargateMain'
    return 'StargateSecondary'
  endif
  return 'StargateMain'
enddef

def ShowStargates(destinations: list<list<number>>): dict<any>
  const length = len(destinations)
  const names = Designations(length)
  var prev = { orbit: -1, degree: -1, len: 0, color: 'StargateMain' }
  var stargates: dict<any>

  # Check if some outside force closed some of stargate popups
  # mostly for popup_clear(), will fail on some manual popup_remove(id)
  if empty(popup_getpos(label_windows[g:stargate_chars[0]]))
    for id in values(label_windows)
      popup_close(id)
    endfor
    CreateLabelWindows()
  endif

  const galaxy_distant_orbit = win_screenpos(0)[0] - 1 + winheight(0)
  for i in range(length)
    const orbit = destinations[i][0]
    const degree = destinations[i][1]
    const scr_pos = screenpos(0, orbit, degree)
    if scr_pos.row > galaxy_distant_orbit
      break
    endif
    const name = names[i]
    const id = label_windows[name]
    const color = ChooseColor(prev, orbit, degree)
    const zindex = 100 + i
    popup_move(id, { line: scr_pos.row, col: scr_pos.curscol })
    popup_setoptions(id, { highlight: color, zindex: zindex })
    popup_show(id)
    stargates[name] = { id: id, orbit: orbit, degree: degree, color: color, zindex: zindex }
    prev = { orbit: orbit, degree: degree, len: len(name), color: color }
  endfor

  return stargates
enddef

def GetDestinations(pattern: string): dict<any>
  var destinations = GalaxyStars(TransformPattern(pattern))
  const length = len(destinations)

  var stargates: dict<any>
  if length == 0
    stargates = {}
  elseif length == 1
    stargates = {jump: {orbit: destinations[0][0], degree: destinations[0][1]}}
  elseif length > g:stargate_limit
    throw $'stargate: too much popups to show - {length}'
  else
    Desaturate()
    stargates = destinations->ShowStargates()
  endif

  return stargates
enddef

var in_visual_mode: bool
var is_hlsearch: bool
var stargate_visual: list<dict<any>>
var stargate_showmode: bool
const match_paren_enabled = exists(':DoMatchParen') == 2 ? true : false

def HideLabels(stargates: dict<any>)
  for v in values(stargates)
    popup_hide(v.id)
  endfor
enddef


def Saturate()
  RemoveMatchHighlight(win['StargateError'])
  RemoveMatchHighlight(win['StargateDesaturate'])
enddef


def HideStarsHints()
  for v in values(label_windows)
    popup_hide(v)
  endfor
enddef


def Greetings()
  winview = winsaveview()

  in_visual_mode = mode() != 'n'
  if in_visual_mode
    stargate_showmode = &showmode
    &showmode = 0
    stargate_visual = hlget('Visual')
    hlset([{name: 'Visual', cleared: true, linksto: 'StargateVisual'}])
  endif

  UpdateWinBounds()

  is_hlsearch = v:hlsearch
  if is_hlsearch
    &hlsearch = 0
  endif

  if match_paren_enabled
    RemoveMatchHighlight(3)
  endif

  SetScreen()
  StandardMessage('choose a destination.')
enddef


def Goodbye()
  HideStarsHints()
  Saturate()
  ClearScreen()

  # rehighlight matched paren
  doautocmd CursorMoved

  if is_hlsearch
    &hlsearch = 1
  endif

  if in_visual_mode
    &showmode = stargate_showmode
    hlset(stargate_visual)
  endif
enddef


def ShowFiltered(stargates: dict<any>)
  for [label, stargate] in items(stargates)
    const id = label_windows[label]
    const scr_pos = screenpos(0, stargate.orbit, stargate.degree)
    popup_move(id, { line: scr_pos.row, col: scr_pos.col })
    popup_setoptions(id, { highlight: stargate.color, zindex: stargate.zindex })
    popup_show(id)
    stargates[label].id = id
  endfor
enddef


def UseStargate(destinations: dict<any>)
  var stargates = copy(destinations)
  StandardMessage('Select a stargate for a jump.')
  while true
    var filtered = {}
    const [nr: number, err: bool] = SafeGetChar()

    if err || nr == 27  # 27 is <Esc>
      BlankMessage()
      return
    endif

    const char = nr2char(nr)
    for [label, stargate] in items(stargates)
      if match(label, char) == 0
        const new_label = strcharpart(label, 1)
        filtered[new_label] = stargate
      endif
    endfor

    if empty(filtered)
      Error($'Wrong stargate, {g:stargate_name}. Choose another one.')
    elseif len(filtered) == 1
      BlankMessage()
      cursor(filtered[''].orbit, filtered[''].degree)
      return
    else
      HideLabels(stargates)
      ShowFiltered(filtered)
      stargates = copy(filtered)
      StandardMessage('Select a stargate for a jump.')
    endif
  endwhile
enddef


def ChooseDestinations(mode: number): dict<any>
  var to_galaxy = false
  var destinations = {}
  var pattern: string
  while true
    var nrs = []
    for _ in range(mode)
      const [nr: number, err: bool] = SafeGetChar()

      if err || nr == 27  # 27 is <Esc>
        BlankMessage()
        return {}
      endif

      if nr == 23  # 23 is <C-w>
        to_galaxy = true
        break
      endif

      nrs->add(nr)
    endfor

    if to_galaxy
      to_galaxy = false
      if in_visual_mode || InOperatorPendingMode()
        Error($'It is impossible to do now, {g:stargate_name}.')
      endif
      winview = winsaveview()

      # if current window after the jump is in terminal or insert modes - quit stargate
      if match(mode(), '[ti]') == 0
        throw "stargate: can't work in terminal or insert mode."
      endif
      continue
    endif

    pattern = nrs
          ->mapnew((_, v) => nr2char(v))
          ->join('')
    destinations = GetDestinations(pattern)
    if empty(destinations)
      Error($"We can't reach there, {g:stargate_name}.")
      continue
    endif
    break
  endwhile

  return destinations
enddef

const max_col = 5000
var label_windows: dict<number>
var winview: dict<any>
var win: dict<any> = {
  topline: 0,
  botline: 0,
  lines_range: [],
  StargateFocus: 0,
  StargateDesaturate: 0,
  StargateError: 0,
}
var conceal_level: number
var fake_cursor_match_id: number


# Creates plugin highlights
def CreateHighlights()
  highlight default StargateFocus guifg=#bd4637
  highlight default StargateDesaturate guifg=#49423f
  highlight default StargateError guifg=#d35b4b
  highlight default StargateLabels guifg=#caa247 guibg=#171e2c
  highlight default StargateErrorLabels guifg=#caa247 guibg=#551414
  highlight default StargateMain guifg=#f2119c gui=bold cterm=bold
  highlight default StargateSecondary guifg=#11eb9c gui=bold cterm=bold
  highlight default StargateShip guifg=#111111 guibg=#caa247
  highlight default StargateVIM9000 guifg=#111111 guibg=#b2809f gui=bold cterm=bold
  highlight default StargateMessage guifg=#a5b844
  highlight default StargateErrorMessage guifg=#e36659
  highlight default link StargateVisual Visual
enddef


# Returns first window column number after signcolumn
def DisplayLeftEdge(): number
  return win_getid()
      ->getwininfo()[0].textoff + 1
enddef


# Returns `true` if 'list' option is set and 'listchars' has 'precedes'
def ListcharsHasPrecedes(): bool
  return &list && match(&listchars, 'precedes') != -1
enddef


# Creates new matchadd highlight and additionally removes any leftover
# highlights from the previous highlighting of this `match_group`
# Useful when adding match highlight with the `timer_start()`
def AddMatchHighlight(match_group: string, priority: number)
  const id = matchaddpos(match_group, win.lines_range, priority)
  RemoveMatchHighlight(win[match_group])
  win[match_group] = id
enddef

# Silently removes match highlight with `match_id`
def RemoveMatchHighlight(match_id: number)
  silent! call matchdelete(match_id)
enddef

# Returns first and last visible virtual columns of the buffer in the current window
def OrbitalArc(): dict<number>
  const edge = DisplayLeftEdge()
  var last_degree = 0
  var first_degree = virtcol('.') - wincol() + edge
  if first_degree > 1 && ListcharsHasPrecedes()
    first_degree += 1
    last_degree -= 1
  endif
  last_degree += first_degree + winwidth(0) - edge
  return { first: first_degree, last: last_degree }
enddef


# Sets some new values for global `win` dictionary
def UpdateWinBounds()
  win.topline = line('w0')
  win.botline = line('w$')
  win.lines_range = range(win.topline, win.botline)
enddef


# Returns list of all visible lines of the current window buffer from top to bottom.
# Excluding folded lines
def OrbitsWithoutBlackmatter(near: number, distant: number): list<number>
  var current = near
  var orbits = []
  while current <= distant
    const last_bm_orbit = foldclosedend(current)
    # foldclosedend() returns -1 if not in closed fold
    if last_bm_orbit != -1
      current = last_bm_orbit + 1
    else
      orbits->add(current)
      current += 1
    endif
  endwhile

  return orbits
enddef


# Returns new pattern with all alternative branches for pattern
# found in g:stargate_keymaps or unmodified
def ProcessKeymap(pattern: string): string
  var pat: string
  for char in (split(pattern, '\zs'))
    const rhs = get(g:stargate_keymaps, char, '')
    if empty(rhs)
      pat ..= char
    else
      pat ..= $'\[{char}{rhs}]'
    endif
  endfor

  return pat
enddef


# Retruns true in operator-pending mode
def InOperatorPendingMode(): bool
  return state()[0] == 'o'
enddef


def TransformPattern(pattern: string): string
  if pattern == ' '
    return '\S\zs\s'
  endif

  var pat = pattern
  const prefix = '\V' .. (g:stargate_ignorecase ? '\c' : '\C')
  if !empty(g:stargate_keymaps)
    pat = ProcessKeymap(pat)
  endif

  return prefix .. pat
enddef


def LabelLists(chars: list<string>, length: number): dict<any>
  const chars_len = len(chars)
  const one_less = chars_len - 1
  var total_len = length
  var label_array = [copy(chars)]

  var index = 0
  var i1 = index / chars_len
  var i2 = index % chars_len
  while total_len > chars_len
    const char = label_array[i1][i2]
    label_array->add(MapnewConcat(chars, char))
    total_len -= one_less
    index += 1
    i1 = index / chars_len
    i2 = index % chars_len
  endwhile

  const labels_len = len(label_array)
  const end_row = labels_len - 1
  const end_col = chars_len - (labels_len * chars_len - length - index + 1)

  return {
    labels: label_array,
    len: chars_len,
    start_row: i1,
    start_col: i2,
    end_row: end_row,
    end_col: end_col
  }
enddef


# Returns new list with each string element in it prefixed with `char`
# MapnewConcat(['x', 'y', 'z'], 'a') -> ['ax', 'ay', 'az']
def MapnewConcat(strings: list<string>, char: string): list<string>
  var result = []
  for str in strings
    result->add(char .. str)
  endfor
  return result
enddef


# Returns result and error state, but do not break out
# from invoking of getchar() immediately. Replaces all NaN results with -1
def SafeGetChar(): list<any>
  var nr: number
  var err = false
  try
    nr = getchar()
    if type(nr) != v:t_number
      nr = -1
    endif
  catch
    err = true
  endtry
  return [nr, err]
enddef


def CreateLabelWindows()
  label_windows = {}
  const label_array = LabelLists(g:stargate_chars, g:stargate_limit).labels->flattennew(1)
  for ds in label_array
    label_windows[ds] = popup_create(ds, { line: 0, col: 0, hidden: true, wrap: false, tabpage: -1 })
  endfor
enddef


var HideCursor: func()
var ShowCursor: func()
# Hiding the cursor when awaiting for char of getchar() function
# done differently in gui and terminal
if has('gui_running')
  var cursor_state: list<dict<any>>
  HideCursor = () => {
    cursor_state = hlget('Cursor')
    hlset([{name: 'Cursor', cleared: true}])
  }
  ShowCursor = () => {
    hlset(cursor_state)
  }
else
  var cursor_state: string
  HideCursor = () => {
    cursor_state = &t_ve
    &t_ve = ''
  }
  ShowCursor = () => {
    &t_ve = cursor_state
  }
endif


def SetScreen()
  conceal_level = &conceallevel
  &conceallevel = 0
  HideCursor()

  fake_cursor_match_id = matchaddpos('StargateShip', [[line('.'), col('.')]], 1010)
  AddMatchHighlight('StargateFocus', 1000)
enddef


def ClearScreen()
  RemoveMatchHighlight(win['StargateFocus'])
  RemoveMatchHighlight(fake_cursor_match_id)
  ShowCursor()
  &conceallevel = conceal_level
enddef

g:stargate_ignorecase = get(g:, 'stargate_ignorecase', true)
g:stargate_limit = get(g:, 'stargate_limit', 300)
g:stargate_chars = get(g:, 'stargate_chars', 'fjdklshgaewiomc')->split('\zs')
g:stargate_name = get(g:, 'stargate_name', 'Human')
g:stargate_keymaps = get(g:, 'stargate_keymaps', {})

# Apply highlights on a colorscheme change
export def Stargate(mode: any)
  try
    Greetings()
    var destinations = ChooseDestinations(mode)
    if !empty(destinations)
      normal! m'
      if len(destinations) == 1
        BlankMessage()
        cursor(destinations.jump.orbit, destinations.jump.degree)
      else
        UseStargate(destinations)
      endif
    endif
  catch
    winrestview(winview)
    if v:exception =~ '^\s*stargate:'
      Warning(v:exception)
    else
      redraw
      exe $'echoerr "{v:exception}"'
    endif
  finally
    Goodbye()
  endtry
enddef


CreateHighlights()
augroup StargateReapplyHighlights
  autocmd!
  autocmd ColorScheme * CreateHighlights()
augroup END
CreateLabelWindows()

defcompile
# vim: sw=4
