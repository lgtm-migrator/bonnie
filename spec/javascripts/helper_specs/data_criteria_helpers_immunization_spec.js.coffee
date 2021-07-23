describe 'DataCriteriaHelpers', ->

  describe 'Immunization Attributes', ->
    it 'should support Immunization.status', ->
      DataCriteriaAsserts.assertCode('Immunization', 'status', 'status', (fhirResource) -> cqm.models.ImmunizationStatus.isImmunizationStatus(fhirResource.status))

    it 'should support Immunization.occurrence as datatime', ->
      DataCriteriaAsserts.assertDateTime('Immunization', 'occurrence', 'occurrence')

    it 'should choice types of Immunization.occurrence', ->
      attrs = DataCriteriaHelpers.DATA_ELEMENT_ATTRIBUTES['Immunization']
      attr = attrs.find (attr) -> attr.path is 'occurrence'
      expect(attr.path).toEqual 'occurrence'
      expect(attr.types.length).toBe 1
      expect(attr.types).toEqual ['DateTime',]
