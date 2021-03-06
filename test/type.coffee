suite 'Type', ->
  suite 'Assignment', ->
    test 'basic assign', ->
      x :: Number = 3
      eq x, 3

    test 'throw type mismatch', ->
      throws ->
        CoffeeScript.parse """
          x :: Number = "3"
        """

    test 'object assign', ->
      obj :: { x :: Number} = { x : 2}

    # test 'throw object literal mitmatching', ->
    #   throws ->
    #     CoffeeScript.parse """
    #       obj :: { x :: Number } = { x : '' }
    #     """

    test 'throw member access error', ->
      throws ->
        CoffeeScript.parse """
          obj :: { x :: Number } = { x : 3 }
          obj.x = ""
        """

    test 'object literal with newline', ->
      p :: {
        x :: Number
        y :: Number
      } = {x : 1, y: 5}

    test 'any type thorough everything', ->
      a :: Any = 3
      a = false
      eq a, false

    test 'typed function and binding', ->
      f :: Number -> Number = (n :: Number) ->  n * n
      n :: Number  = f 4

    test 'typed function with return type', ->
      f :: Number -> Number = (n :: Number) :: Number ->  n * n
      n :: Number  = f 4

    test 'return function type', ->
      fh = (n :: Number) :: (Number -> Number) -> (m)-> n * m
      eq fh(2)(3), 6

    test 'avoid polution about prototype', ->
      class X
      X::x = 3
      eq X.prototype.x, 3
