Tinytest.add 'Package exposes things correctly', (test) ->
  for exposed in testData.packageExposes
    test.isTrue Soap[exposed], "Soap must expose #{exposed}"


Tinytest.addAsync 'Package has correct behaviour', (test, next) ->
  soapServer = Soap.listen '/soap', testData.serviceDefinition,
    testData.wsdlDefinition

  Meteor.setTimeout ->
    try
      soapClient = Soap.createClient Meteor.absoluteUrl 'soap?wsdl'
      test.equal soapClient.describe(), testData.expectedDescription,
        'Soap client description differs from expected'
    catch err
    test.isUndefined err, 'Soap client creation failed'

    try
      response = soapClient.MyOperation testData.requestData
      test.equal response, testData.responseData,
        'Soap shortcut method call result differs from expected'
    catch err
    test.isUndefined err, 'Soap shortcut method call failed'

    try
      response = soapClient.MyService.MyServicePort.MyOperation testData.requestData
      test.equal response, testData.responseData,
        'Soap method call result differs from expected'
    catch err
    test.isUndefined err, 'Soap method call failed'

    try
      soapClient.MyOperation {}
    catch err
    test.equal err.error, testData.methodCallFailed,
      'Incorrectly invoked soap method must throw'

    try
      Soap.createClient ''
    catch err
    test.equal err.error, testData.clientCreationFailed,
      'createClient must throw on error'

    next()
  , 0
