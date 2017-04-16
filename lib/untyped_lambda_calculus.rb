require "untyped_lambda_calculus/version"

module UntypedLambdaCalculus
  ZERO = ->(*) { ->(x) { x } }
  ONE  = ->(p) { ->(x) { p[x] } }
  TWO  = ->(p) { ->(x) { p[p[x]] } }

  TRUE  = ->(x) { ->(*) { x } }
  FALSE = ->(*) { ->(y) { y } }

  IF = ->(p) { ->(x) { ->(y) { p[x][y] } } }

  AND = ->(x) { ->(y) { x[y][FALSE] } }
  OR  = ->(x) { ->(y) { x[TRUE][y] } }

  NOT = ->(x) { x[FALSE][TRUE] }

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

  IS_ZERO = ->(n) { n[->(_) { FALSE }][TRUE] }

  LESS_OR_EQ = ->(n) { ->(m) { IS_ZERO[SUB[n][m]] } }

  Y = ->(f) { ->(x) { f[x[x]] }[->(x) { f[x[x]] }] }
  Z = ->(f) { ->(x) { f[->(y) { x[x][y] }] }[->(x) { f[->(y) { x[x][y] }] }] }

  MOD = Z[
    ->(f) {
      ->(n) {
        ->(m) { IF[LESS_OR_EQ[m][n]][->(x) { f[SUB[n][m]][m][x] }][n] }
      }
    }
  ]
end
