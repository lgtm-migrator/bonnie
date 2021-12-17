@MedicationDispenseStatusValueSet = class MedicationDispenseStatusValueSet
  @JSON = {
    "resourceType": "ValueSet",
    "id": "medicationdispense-status",
    "meta": {
      "lastUpdated": "2019-11-01T09:29:23.356+11:00",
      "profile": ["http://hl7.org/fhir/StructureDefinition/shareablevalueset"]
    },
    "text": {
      "status": "generated",
      "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h2>Medication dispense  status  codes</h2><div><p>MedicationDispense Status Codes</p>\n</div><p>This value set includes codes from the following code systems:</p><ul><li>Include all codes defined in <a href=\"codesystem-medicationdispense-status.html\"><code>http://terminology.hl7.org/CodeSystem/medicationdispense-status</code></a></li></ul></div>"
    },
    "extension": [
      {
        "url": "http://hl7.org/fhir/StructureDefinition/structuredefinition-wg",
        "valueCode": "phx"
      },
      {
        "url": "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
        "valueCode": "trial-use"
      },
      {
        "url": "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm",
        "valueInteger": 2
      }
    ],
    "url": "http://hl7.org/fhir/ValueSet/medicationdispense-status",
    "identifier": [
      {
        "system": "urn:ietf:rfc:3986",
        "value": "urn:oid:2.16.840.1.113883.4.642.3.1312"
      }
    ],
    "version": "4.0.1",
    "name": "MedicationDispense Status Codes",
    "title": "Medication dispense  status  codes",
    "status": "draft",
    "experimental": false,
    "date": "2019-11-01T09:29:23+11:00",
    "publisher": "FHIR Project team",
    "contact": [
      {
        "telecom": [
          {
            "system": "url",
            "value": "http://hl7.org/fhir"
          }
        ]
      }
    ],
    "description": "MedicationDispense Status Codes",
    "immutable": true,
    "compose": {
      "include": [
        {
          "system": "http://terminology.hl7.org/CodeSystem/medicationdispense-status",
          "concept": [
            {
              "code": "preparation",
              "display": "Preparation",
              "definition": "The core event has not started yet, but some staging activities have begun (e.g. initial compounding or packaging of medication). Preparation stages may be tracked for billing purposes."
            },
            {
              "code": "in-progress",
              "display": "In Progress",
              "definition": "The dispensed product is ready for pickup."
            },
            {
              "code": "cancelled",
              "display": "Cancelled",
              "definition": "The dispensed product was not and will never be picked up by the patient."
            },
            {
              "code": "on-hold",
              "display": "On Hold",
              "definition": "The dispense process is paused while waiting for an external event to reactivate the dispense.  For example, new stock has arrived or the prescriber has called."
            },
            {
              "code": "completed",
              "display": "Completed",
              "definition": "The dispensed product has been picked up."
            },
            {
              "code": "entered-in-error",
              "display": "Entered in Error",
              "definition": "The dispense was entered in error and therefore nullified."
            },
            {
              "code": "stopped",
              "display": "Stopped",
              "definition": "Actions implied by the dispense have been permanently halted, before all of them occurred."
            },
            {
              "code": "declined",
              "display": "Declined",
              "definition": "The dispense was declined and not performed."
            },
            {
              "code": "unknown",
              "display": "Unknown",
              "definition": "The authoring system does not know which of the status values applies for this medication dispense.  Note: this concept is not to be used for other - one of the listed statuses is presumed to apply, it's just now known which one."
            }
          ]
        }
      ]
    }
  }
