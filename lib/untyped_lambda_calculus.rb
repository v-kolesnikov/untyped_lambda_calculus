require "untyped_lambda_calculus/version"

module UntypedLambdaCalculus
  ZERO = ->(*) { ->(x) { x } }
  ONE  = ->(p) { ->(x) { p[x] } }
  TWO  = ->(p) { ->(x) { p[p[x]] } }

  TRUE  = ->(x) { ->(*) { x } }
  FALSE = ->(*) { ->(y) { y } }

  IF = ->(p) { ->(x) { ->(y) { p[x][y] } } }

  PAIR  = ->(x) { ->(y) { ->(p) { p[x][y] } } }
  LEFT  = ->(p) { p[->(x) { ->(*) { x } }] }
  RIGHT = ->(p) { p[->(*) { ->(y) { y } }] }

  SLIDE = ->(p) { PAIR[RIGHT[p]][INC[RIGHT[p]]] }

  INC = ->(n) { ->(p) { ->(x) { p[n[p][x]] } } }
  DEC = ->(n) { LEFT[n[SLIDE][PAIR[ZERO][ZERO]]] }

  ADD = ->(n) { ->(m) { m[INC][n] } }
  SUB = ->(n) { ->(m) { m[DEC][n] } }
  MUL = ->(n) { ->(m) { m[ADD[n]][ZERO] } }
  POW = ->(n) { ->(m) { m[MUL[n]][ONE]  } }
end
