# Defines a list of assert methods for data attributes testing
@DataCriteriaAsserts = class DataCriteriaAsserts
  @assertCodingWithType: (resourceType, path, type) ->
    attrs = DataCriteriaHelpers.DATA_ELEMENT_ATTRIBUTES[resourceType]
    expect(attrs).toBeDefined
    attr = attrs.find (attr) -> attr.path is path
    expect(attr.path).toBe path

    fhirResource = new cqm.models[resourceType]()
    expect(attr.getValue(fhirResource)).toBeUndefined

    valueToSet = new cqm.models.Coding()
    valueToSet.code = cqm.models.PrimitiveCode.parsePrimitive('code1')
    valueToSet.system = cqm.models.PrimitiveUrl.parsePrimitive('system1')
    valueToSet = [valueToSet] if attr.isArray

    attr.setValue(fhirResource, valueToSet)

    # clone the resource to make sure setter/getter work with correct data type
    value = attr.getValue(fhirResource.clone())
    expect(value).toBeDefined
    if attr.isArray
      expect(Arrays.isArray(value)).toBe true
      expect(value[0].code.value).toBe 'code1'
      expect(value[0].system.value).toBe 'system1'
    else
      expect(value.code.value).toBe 'code1'
      expect(value.system.value).toBe 'system1'

  @assertCodeableConcept: (resourceType, path) ->
    attrs = DataCriteriaHelpers.DATA_ELEMENT_ATTRIBUTES[resourceType]
    expect(attrs).toBeDefined
    attr = attrs.find (attr) -> attr.path is path
    expect(attr.path).toBe path

    fhirResource = new cqm.models[resourceType]()
    expect(attr.getValue(fhirResource)).toBeUndefined

    coding = new cqm.models.Coding()
    coding.code = cqm.models.PrimitiveCode.parsePrimitive('code1')
    coding.system = cqm.models.PrimitiveUrl.parsePrimitive('system1')

    valueToSet = new cqm.models.CodeableConcept()
    valueToSet.coding = [coding]
    valueToSet = [valueToSet] if attr.isArray

    attr.setValue(fhirResource, valueToSet)

    # clone the resource to make sure setter/getter work with correct data type
    value = attr.getValue(fhirResource.clone())
    expect(value).toBeDefined
    if attr.isArray
      expect(Array.isArray(value)).toBe true
      expect(value[0].coding[0].code.value).toBe 'code1'
      expect(value[0].coding[0].system.value).toBe 'system1'
    else
      expect(Array.isArray(value)).toBe false
      expect(value.coding[0].code.value).toBe 'code1'
      expect(value.coding[0].system.value).toBe 'system1'

  @assertCoding: (resourceType, path) ->
    @assertCodingWithType(resourceType, path,'Coding')

  @assertCode: (resourceType, path, codeClass) ->
    attrs = DataCriteriaHelpers.DATA_ELEMENT_ATTRIBUTES[resourceType]
    expect(attrs).toBeDefined
    attr = attrs.find (attr) -> attr.path is path
    expect(attr).toBeDefined
    expect(attr.path).toBe path

    fhirResource = new cqm.models[resourceType]()
    expect(attr.getValue(fhirResource)).toBeUndefined

    valueToSet = codeClass.parsePrimitive('a code')
    attr.setValue(fhirResource, valueToSet)

    # clone the resource to make sure setter/getter work with correct data type
    value = attr.getValue(fhirResource.clone())
    expect(value).toBeDefined
    expect(value.value).toBe 'a code'

  @assertPeriod: (resourceType, path) ->
    attrs = DataCriteriaHelpers.DATA_ELEMENT_ATTRIBUTES[resourceType]
    attr = attrs.find (attr) -> attr.path is path
    expect(attr.path).toEqual path
    # Create fhir resource and Period
    fhirResource = new cqm.models[resourceType]()
    period = new cqm.models.Period()
    period.start = cqm.models.PrimitiveDateTime.parsePrimitive('2020-09-02T13:54:57')
    period.end = cqm.models.PrimitiveDateTime.parsePrimitive('2020-10-02T13:54:57')
    # set Period
    attr.setValue(fhirResource, period)

    value = attr.getValue(fhirResource.clone())
    # Verify after setting values
    expect(value.start.value).toEqual period.start.value
    expect(value.end.value).toEqual period.end.value

  @assertDateTime: (resourceType, path) ->
    attrs = DataCriteriaHelpers.DATA_ELEMENT_ATTRIBUTES[resourceType]
    attr = attrs.find (attr) -> attr.path is path
    expect(attr.path).toEqual path
    # Create fhir resource and Period
    fhirResource = new cqm.models[resourceType]()

    dateTime = cqm.models.PrimitiveDateTime.parsePrimitive('2020-09-02T13:54:57')

    attr.setValue(fhirResource, dateTime)

    value = attr.getValue(fhirResource.clone())
    # Verify after setting values
    expect(value.value).toEqual dateTime.value

  @assertString: (resourceType, path) ->
    attrs = DataCriteriaHelpers.DATA_ELEMENT_ATTRIBUTES[resourceType]
    attr = attrs.find (attr) -> attr.path is path
    expect(attr.path).toEqual path
    fhirResource = new cqm.models[resourceType]()

    primitiveString = cqm.models.PrimitiveString.parsePrimitive('random string value')

    attr.setValue(fhirResource, primitiveString)

    value = attr.getValue(fhirResource.clone())
    # Verify after setting values
    expect(value.value).toEqual primitiveString.value

  @assertBoolean: (resourceType, path) ->
    attrs = DataCriteriaHelpers.DATA_ELEMENT_ATTRIBUTES[resourceType]
    attr = attrs.find (attr) -> attr.path is path
    expect(attr.path).toEqual path
    fhirResource = new cqm.models[resourceType]()
    primitiveBoolean = cqm.models.PrimitiveBoolean.parsePrimitive(true)
    attr.setValue(fhirResource, primitiveBoolean)
    value = attr.getValue(fhirResource.clone())
    expect(value.value).toEqual primitiveBoolean.value

  @assertReference: (resourceType, path) ->
    attrs = DataCriteriaHelpers.DATA_ELEMENT_ATTRIBUTES[resourceType]
    attr = attrs.find (attr) -> attr.path is path
    expect(attr.path).toEqual path

    test_reference = new cqm.models.Reference()
    test_reference.reference = "http://someserver/some-path"
    test_reference.type = "patient"

    fhirResource = new cqm.models[resourceType]()
    attr.setValue(fhirResource, test_reference)

    value = attr.getValue(fhirResource)
    expect(value).toBeDefined
    expect(value.type).toBe 'patient'
    expect(value.reference).toBe 'http://someserver/some-path'


