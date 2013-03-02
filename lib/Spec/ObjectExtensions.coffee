window.Spec ||= {}

window.Spec.ObjectExtensions = 
  # Stubs a method on object
  stub: (method) ->
    stub = if @[method] && @[method]._stub
      @[method]._stub
    else
      new Spec.MethodStub(window.test, this, method)
    stub.possibleCall()

  # Tests for a positive match
  should: (matcher) ->
    result = matcher(this)
    Spec.fail "expected #{result[1]}" unless result[0]

  # Tests for a negative match
  shouldNot: (matcher) ->
    result = matcher(this)
    Spec.fail "expected not #{result[1]}" if result[0]

  # Creates a stub method with an expectation
  shouldReceive: (method) ->
    @stub(method).expect()

  # Creates a stub method, with an expectation of no calls
  shouldNotReceive: (name) ->
    @shouldReceive(name).exactly(0).times
