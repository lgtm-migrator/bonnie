# Description http://hl7.org/fhir/ValueSet/event-timing
# This value set is used in the following places:
# Resource: Timing.repeat.when (code / Required)
@EventStatusValueSet = class EventStatusValueSet
  @JSON = {
    "resourceType": "ValueSet",
    "id": "event-status",
    "meta": {
      "lastUpdated": "2019-11-01T09:29:23.356+11:00",
      "profile": ["http://hl7.org/fhir/StructureDefinition/shareablevalueset"]
    },
    "text": {
      "status": "generated",
      "div": "<div>!-- Snipped for Brevity --></div>"
    },
    "extension": [{
      "url": "http://hl7.org/fhir/StructureDefinition/structuredefinition-wg",
      "valueCode": "fhir"
    },
      {
        "url": "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
        "valueCode": "trial-use"
      },
      {
        "url": "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm",
        "valueInteger": 3
      }],
    "url": "http://hl7.org/fhir/ValueSet/event-status",
    "identifier": [{
      "system": "urn:ietf:rfc:3986",
      "value": "urn:oid:2.16.840.1.113883.4.642.3.109"
    }],
    "version": "4.0.1",
    "name": "EventStatus",
    "title": "EventStatus",
    "status": "draft",
    "experimental": false,
    "date": "2019-11-01T09:29:23+11:00",
    "publisher": "HL7 (FHIR Project)",
    "contact": [{
      "telecom": [{
        "system": "url",
        "value": "http://hl7.org/fhir"
      },
        {
          "system": "email",
          "value": "fhir@lists.hl7.org"
        }]
    }],
    "description": "Codes identifying the lifecycle stage of an event.",
    "immutable": true,
    "compose": {
      "include": [{
        "system": "http://hl7.org/fhir/event-status",
        "concept" : [
            {
              "code": "preparation",
              "display": "Preparation"
            },
            {
              "code": " in-progress",
              "display": "In Progress"
            },
            {
              "code": "not-done",
              "display": "Not Done"
            },
             {
              "code": "on-hold",
              "display": "On Hold"
            },
             {
              "code": "stopped",
              "display": "Stopped"
            },
            {
              "code": "completed",
              "display": "Completed"
            },
            {
              "code": "entered-in-error",
              "display": "Entered in Error"
            },
             {
              "code": "unknown",
              "display": "Unknown"
            }
          ]
      }]
    }
  }