@DataCriteriaHelpers = class DataCriteriaHelpers

  @PRIMARY_TIMING_ATTRIBUTES:
    AdverseEvent: { date: 'dateTime', detected: 'dateTime', recordedDate: 'dateTime' },
    AllergyIntolerance: { recordedDate: 'dateTime', lastOccurrence: 'dateTime' },
    Condition: { recordedDate: 'dateTime' },
    FamilyMemberHistory: { date: 'dateTime' },
    Coverage: { period: 'Period' },
    DiagnosticReport: { issued: 'instant' },
    ImagingStudy: { started: 'DateTime' },
    Observation: { issued: 'instant' },
    Specimen: { receivedTime: 'dateTime' },
    CarePlan: { period: 'Period', created: 'DateTime' },
    CareTeam: { period: 'Period' },
    Goal: { statusDate: 'date' },
    NutritionOrder: { dateTime: 'dateTime' },
    ServiceRequest: { authoredOn: 'dateTime' },
    Claim: { billablePeriod: 'Period', created: 'dateTime' },
    Communication: { sent: 'dateTime', received: 'dateTime' },
    CommunicationRequest: { authoredOn: 'dateTime' },
    DeviceRequest: { authoredOn: 'dateTime' },
    DeviceUseStatement: { recordedOn: 'dateTime' },
    Device: { manufactureDate: 'dateTime', expirationDate: 'dateTime' },
    Encounter: { period: 'Period' },
    Flag: { period: 'Period' },
    Immunization: { recorded: 'dateTime', expirationDate: 'date' },
    ImmunizationEvaluation: { date: 'dateTime' },
    ImmunizationRecommendation: { date: 'dateTime' },
    MedicationDispense: { whenPrepared: 'dateTime', whenHandedOver: 'dateTime' },
    MedicationRequest: { authoredOn: 'dateTime' },
    MedicationStatement: { dateAsserted: 'dateTime' },
    Practitioner: { birthDate: 'date' },
    PractitionerRole: { period: 'Period' },
    RelatedPerson: { period: 'Period', birthDate: 'date' },
    Task: { executionPeriod: 'Period', authoredOn: 'dateTime', lastModified: 'dateTime' }

  @DATA_ELEMENT_CATEGORIES:
    AdverseEvent:       'clinical summary'
    AllergyIntolerance: 'clinical summary'
    Condition:          'clinical summary'
    FamilyMemberHistory:'clinical summary'
    Procedure:          'clinical summary'

    Coverage: 'financial support'

    BodyStructure:    'diagnostics'
    DiagnosticReport: 'diagnostics'
    ImagingStudy:     'diagnostics'
    Observation:      'diagnostics'
    Specimen:         'diagnostics'

    CarePlan:       'care provision'
    CareTeam:       'care provision'
    Goal:           'care provision'
    NutritionOrder: 'care provision'
    ServiceRequest: 'care provision'

    Claim: 'billing'

    Communication:        'request response'
    CommunicationRequest: 'request response'
    DeviceRequest:        'request response'
    DeviceUseStatement:   'request response'

    Location: 'providers entities'

    Device:    'material entities'
    Substance: 'material entities'

    Encounter: 'management'
    flag:      'management'

    Immunization:               'medications'
    ImmunizationEvaluation:     'medications'
    ImmunizationRecommendation: 'medications'
    Medication:                  'medications'
    MedicationAdministration:    'medications'
    MedicationDispense:         'medications'
    MedicationRequest:          'medications'
    MedicationStatement:        'medications'

    Patient:          'individuals'
    Practitioner:     'individuals'
    PractitionerRole: 'individuals'
    RelatedPerson:    'individuals'

    Task: 'workflow'

  @createIntervalFromPeriod: (period) ->
    startDate = @getCQLDateTimeFromString(period.start.value)
    endDate = @getCQLDateTimeFromString(period.end.value)
    new cqm.models.CQL.Interval(startDate, endDate)

  @getCQLDateTimeFromString: (dateStr) ->
    date = new Date(dateStr)
    cqm.models.CQL.DateTime.fromJSDate(date, 0)

  @getCQLDateFromString: (dateStr) ->
    date = new Date(dateStr)
    cqm.models.CQL.Date.fromJSDate(date)

  @createPeriodFromInterval: (interval) ->
    period = new cqm.models.Period()
    period.start = cqm.models.PrimitiveDateTime.parsePrimitive interval.low.toString()
    period.end = cqm.models.PrimitiveDateTime.parsePrimitive interval.high.toString()
    return period

  @getPrimitiveDateTimeForCqlDateTime: (dateTime) ->
    cqm.models.PrimitiveDateTime.parsePrimitive dateTime?.toString()

  @getPrimitiveInstantForCqlDateTime: (dateTime) ->
    cqm.models.PrimitiveInstant.parsePrimitive dateTime?.toString()

  @getPrimitiveDateForCqlDate: (date) ->
    cqm.models.PrimitiveDate.parsePrimitive date?.toString()

