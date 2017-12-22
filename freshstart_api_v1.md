# API Freshstart

L'API Freshstart fonctionne uniquement en JSON.

Elle est constituée de 2 API de haut niveau : Courses et Coureurs.




# Group API Résultat de Courses
L'API Courses est organisée hiérarchiquement : Évènements > Éditions > Courses > Résultats.

## Éditions [/editions]
Une édition d'un évènement contient plusieurs courses.

### Obtenir toutes les éditions d'un évènement [GET /api/v1/events/{event_id}/editions]

+ Parameters
    + event_id: `3770` (number, required)

+ Request return a list of editions for an event
**GET**&nbsp;&nbsp;`/api/v1/events/3770/editions`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            [
              {
                "date": "2017-12-22",
                "description": "Desc_1",
                "email_sender": "contact@race_1.com",
                "hashtag": "#HASH1",
                "results_url": "results_1.com",
                "sms_message": "Congratulation for Race1",
                "template": "Template_1",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race1.com",
                "external_link_button": "Button_race1.com",
                "created_at": "2017-12-22T01:52:47.173+01:00",
                "updated_at": "2017-12-22T01:52:47.173+01:00",
                "raw_results_file_name": "raw_Race1",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race1",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null,
                "event": {
                  "name": "Event_1",
                  "place": "Place_1",
                  "website": "www.event_1.com",
                  "facebook": "Event_1",
                  "twitter": "@Event_1",
                  "instagram": "@Event_1",
                  "contact": "contact@event_1.com",
                  "email": "contact@event_1.com",
                  "phone": "+3311111111",
                  "created_at": "2017-12-22T01:52:47.145+01:00",
                  "updated_at": "2017-12-22T01:52:47.145+01:00"
                }
              }
            ]

### Obtenir une édition [GET /api/v1/editions/{id}]

+ Parameters
    + id: `2218` (number, required)

+ Request return the edition
**GET**&nbsp;&nbsp;`/api/v1/editions/2218`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "date": "2017-12-22",
              "description": "Desc_2",
              "email_sender": "contact@race_2.com",
              "hashtag": "#HASH2",
              "results_url": "results_2.com",
              "sms_message": "Congratulation for Race2",
              "template": "Template_2",
              "widget_generated_at": null,
              "photos_widget_generated_at": null,
              "external_link": "Race2.com",
              "external_link_button": "Button_race2.com",
              "created_at": "2017-12-22T01:52:47.234+01:00",
              "updated_at": "2017-12-22T01:52:47.234+01:00",
              "raw_results_file_name": "raw_Race2",
              "raw_results_content_type": "text/csv",
              "raw_results_file_size": 19024,
              "raw_results_updated_at": null,
              "background_image_file_name": "raw_Race2",
              "background_image_content_type": "image/jpg",
              "background_image_file_size": 19024,
              "background_image_updated_at": null,
              "event": {
                "name": "Event_2",
                "place": "Place_2",
                "website": "www.event_2.com",
                "facebook": "Event_2",
                "twitter": "@Event_2",
                "instagram": "@Event_2",
                "contact": "contact@event_2.com",
                "email": "contact@event_2.com",
                "phone": "+3322222222",
                "created_at": "2017-12-22T01:52:47.231+01:00",
                "updated_at": "2017-12-22T01:52:47.231+01:00"
              }
            }

+ Request return Not found
**GET**&nbsp;&nbsp;`/api/v1/editions/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Ajouter une édition à un évènement [POST /api/v1/events/{event_id}/editions]

+ Parameters
    + event_id: `3773` (number, required)

+ Request create a new edition for an event
**POST**&nbsp;&nbsp;`/api/v1/events/3773/editions`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "edition": {
                "date": "2017-12-22T00:52:47+00:00",
                "description": "Desc_5",
                "email_sender": "contact@race_5.com",
                "email_name": "Race_5",
                "hashtag": "#HASH5",
                "results_url": "results_5.com",
                "sms_message": "Congratulation for Race5",
                "raw_results_file_name": "raw_Race5",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "background_image_file_name": "raw_Race5",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "template": "Template_5",
                "external_link": "Race5.com",
                "external_link_button": "Button_race5.com"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "date": "2017-12-22",
              "description": "Desc_5",
              "email_sender": "contact@race_5.com",
              "hashtag": "#HASH5",
              "results_url": "results_5.com",
              "sms_message": "Congratulation for Race5",
              "template": "Template_5",
              "widget_generated_at": null,
              "photos_widget_generated_at": null,
              "external_link": "Race5.com",
              "external_link_button": "Button_race5.com",
              "created_at": "2017-12-22T01:52:47.270+01:00",
              "updated_at": "2017-12-22T01:52:47.270+01:00",
              "raw_results_file_name": "raw_Race5",
              "raw_results_content_type": "text/csv",
              "raw_results_file_size": 19024,
              "raw_results_updated_at": null,
              "background_image_file_name": "raw_Race5",
              "background_image_content_type": "image/jpg",
              "background_image_file_size": 19024,
              "background_image_updated_at": null,
              "event": {
                "name": "Event_4",
                "place": "Place_4",
                "website": "www.event_4.com",
                "facebook": "Event_4",
                "twitter": "@Event_4",
                "instagram": "@Event_4",
                "contact": "contact@event_4.com",
                "email": "contact@event_4.com",
                "phone": "+3344444444",
                "created_at": "2017-12-22T01:52:47.254+01:00",
                "updated_at": "2017-12-22T01:52:47.254+01:00"
              }
            }

+ Request return Unprocessable entity
**POST**&nbsp;&nbsp;`/api/v1/events/3774/editions`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "edition": {
                "date": "2017-12-22T00:52:47+00:00",
                "description": "Desc_7",
                "email_sender": "contact@race_7.com",
                "email_name": "Race_7",
                "hashtag": "#HASH7",
                "results_url": "results_7.com",
                "sms_message": "Congratulation for Race7",
                "raw_results_file_name": "raw_Race7",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "background_image_file_name": "raw_Race7",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "template": null,
                "external_link": "Race7.com",
                "external_link_button": "Button_race7.com"
              }
            }

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/events/3775/editions`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/editions`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "edition": {
                "date": "2017-12-22T00:52:47+00:00",
                "description": "Desc_10",
                "email_sender": "contact@race_10.com",
                "email_name": "Race_10",
                "hashtag": "#HASH10",
                "results_url": "results_10.com",
                "sms_message": "Congratulation for Race10",
                "raw_results_file_name": "raw_Race10",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "background_image_file_name": "raw_Race10",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "template": "Template_9",
                "external_link": "Race10.com",
                "external_link_button": "Button_race10.com"
              }
            }

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Mettre à jour une édition [PUT /api/v1/editions/{id}]

+ Parameters
    + id: `2225` (number, required)

+ Request return Success
**PUT**&nbsp;&nbsp;`/api/v1/editions/2225`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "edition": {
                "date": "2017-12-22T00:52:47+00:00",
                "description": "Desc_12",
                "email_sender": "contact@race_12.com",
                "email_name": "Race_12",
                "hashtag": "#HASH12",
                "results_url": "results_12.com",
                "sms_message": "Congratulation for Race12",
                "raw_results_file_name": "raw_Race12",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "background_image_file_name": "raw_Race12",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "template": "Template_11",
                "external_link": "Race12.com",
                "external_link_button": "Button_race12.com"
              }
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "date": "2017-12-22",
              "description": "Desc_12",
              "email_sender": "contact@race_12.com",
              "hashtag": "#HASH12",
              "results_url": "results_12.com",
              "sms_message": "Congratulation for Race12",
              "template": "Template_11",
              "widget_generated_at": null,
              "photos_widget_generated_at": null,
              "external_link": "Race12.com",
              "external_link_button": "Button_race12.com",
              "created_at": "2017-12-22T01:52:47.325+01:00",
              "updated_at": "2017-12-22T01:52:47.331+01:00",
              "raw_results_file_name": "raw_Race12",
              "raw_results_content_type": "text/csv",
              "raw_results_file_size": 19024,
              "raw_results_updated_at": null,
              "background_image_file_name": "raw_Race12",
              "background_image_content_type": "image/jpg",
              "background_image_file_size": 19024,
              "background_image_updated_at": null,
              "event": {
                "name": "Event_8",
                "place": "Place_8",
                "website": "www.event_8.com",
                "facebook": "Event_8",
                "twitter": "@Event_8",
                "instagram": "@Event_8",
                "contact": "contact@event_8.com",
                "email": "contact@event_8.com",
                "phone": "+3388888888",
                "created_at": "2017-12-22T01:52:47.323+01:00",
                "updated_at": "2017-12-22T01:52:47.323+01:00"
              }
            }

+ Request return Not Modified
**PUT**&nbsp;&nbsp;`/api/v1/editions/2226`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "edition": {
                "date": "2017-12-22T00:52:47+00:00",
                "description": "Desc_14",
                "email_sender": "contact@race_14.com",
                "email_name": "Race_14",
                "hashtag": "#HASH14",
                "results_url": "results_14.com",
                "sms_message": "Congratulation for Race14",
                "raw_results_file_name": "raw_Race14",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "background_image_file_name": "raw_Race14",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "template": null,
                "external_link": "Race14.com",
                "external_link_button": "Button_race14.com"
              }
            }

+ Response 304

    + Body



### Supprimer une édition [DELETE /api/v1/editions/{id}]

+ Parameters
    + id: `2227` (number, required)

+ Request return No content
**DELETE**&nbsp;&nbsp;`/api/v1/editions/2227`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 204

    + Body



+ Request return Not Found
**DELETE**&nbsp;&nbsp;`/api/v1/editions/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



## Évènements [/events]
Un évènement contient plusieurs éditions.

### Obtenir tous les évènements [GET /api/v1/events]


+ Request return a list of events
**GET**&nbsp;&nbsp;`/api/v1/events`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            [
              {
                "name": "Event_12",
                "place": "Place_12",
                "website": "www.event_12.com",
                "facebook": "Event_12",
                "twitter": "@Event_12",
                "instagram": "@Event_12",
                "contact": "contact@event_12.com",
                "email": "contact@event_12.com",
                "phone": "+331212121212121212",
                "created_at": "2017-12-22T01:52:47.805+01:00",
                "updated_at": "2017-12-22T01:52:47.805+01:00"
              }
            ]

### Obtenir un évènement particulier [GET /api/v1/events/{id}]

+ Parameters
    + id: `3782` (number, required)

+ Request return the event
**GET**&nbsp;&nbsp;`/api/v1/events/3782`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "name": "Event_13",
              "place": "Place_13",
              "website": "www.event_13.com",
              "facebook": "Event_13",
              "twitter": "@Event_13",
              "instagram": "@Event_13",
              "contact": "contact@event_13.com",
              "email": "contact@event_13.com",
              "phone": "+331313131313131313",
              "created_at": "2017-12-22T01:52:47.812+01:00",
              "updated_at": "2017-12-22T01:52:47.812+01:00"
            }

+ Request return Not found
**GET**&nbsp;&nbsp;`/api/v1/events/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Créer un évènement [POST /api/v1/events]


+ Request create a new event
**POST**&nbsp;&nbsp;`/api/v1/events`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "event": {
                "name": "Event_16",
                "place": "Place_16",
                "website": "www.event_16.com",
                "facebook": "Event_16",
                "twitter": "@Event_16",
                "instagram": "@Event_16",
                "contact": "contact@event_16.com",
                "email": "contact@event_16.com",
                "phone": "+331616161616161616"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "name": "Event_16",
              "place": "Place_16",
              "website": "www.event_16.com",
              "facebook": "Event_16",
              "twitter": "@Event_16",
              "instagram": "@Event_16",
              "contact": "contact@event_16.com",
              "email": "contact@event_16.com",
              "phone": "+331616161616161616",
              "created_at": "2017-12-22T01:52:47.824+01:00",
              "updated_at": "2017-12-22T01:52:47.824+01:00"
            }

+ Request return Unprocessable entity
**POST**&nbsp;&nbsp;`/api/v1/events`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "event": {
                "name": "",
                "place": "Place_18",
                "website": "www.event_18.com",
                "facebook": "Event_18",
                "twitter": "@Event_18",
                "instagram": "@Event_18",
                "contact": "contact@event_18.com",
                "email": "contact@event_18.com",
                "phone": "+331818181818181818"
              }
            }

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/events`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Mettre à jour un évènement [PUT /api/v1/events/{id}]

+ Parameters
    + id: `3788` (number, required)

+ Request return Success
**PUT**&nbsp;&nbsp;`/api/v1/events/3788`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "event": {
                "name": "Event_20",
                "place": "Place_21",
                "website": "www.event_21.com",
                "facebook": "Event_21",
                "twitter": "@Event_21",
                "instagram": "@Event_21",
                "contact": "contact@event_21.com",
                "email": "contact@event_21.com",
                "phone": "+332121212121212121"
              }
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "name": "Event_20",
              "place": "Place_21",
              "website": "www.event_21.com",
              "facebook": "Event_21",
              "twitter": "@Event_21",
              "instagram": "@Event_21",
              "contact": "contact@event_21.com",
              "email": "contact@event_21.com",
              "phone": "+332121212121212121",
              "created_at": "2017-12-22T01:52:47.837+01:00",
              "updated_at": "2017-12-22T01:52:47.841+01:00"
            }

+ Request return Not Modified
**PUT**&nbsp;&nbsp;`/api/v1/events/3789`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "event": {
                "name": "",
                "place": "Place_23",
                "website": "www.event_23.com",
                "facebook": "Event_23",
                "twitter": "@Event_23",
                "instagram": "@Event_23",
                "contact": "contact@event_23.com",
                "email": "contact@event_23.com",
                "phone": "+332323232323232323"
              }
            }

+ Response 304

    + Body



+ Request return Bad request
**PUT**&nbsp;&nbsp;`/api/v1/events/3790`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "event": null
            }

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Supprimer un évènement [DELETE /api/v1/events/{id}]

+ Parameters
    + id: `3791` (number, required)

+ Request return No content
**DELETE**&nbsp;&nbsp;`/api/v1/events/3791`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 204

    + Body



+ Request return Not Found
**DELETE**&nbsp;&nbsp;`/api/v1/events/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



## Photos [/photos]
Photos prises lors de course. La photo n'est pas nécessairement associé à un coureur de la base (runner)

### Obtenir toutes les photos d'une course ou d'une édition [GET /api/v1/races/{race_id}/photos]

+ Parameters
    + race_id: `ed5644bf-2c69-4ab3-af49-f634b6ff5f14` (string, required)

+ Request return its list of photos
**GET**&nbsp;&nbsp;`/api/v1/races/ed5644bf-2c69-4ab3-af49-f634b6ff5f14/photos`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            [
              {
                "photos": {
                  "id": "94238c88-e52e-4384-8e47-137380abe3db",
                  "race_id": "ed5644bf-2c69-4ab3-af49-f634b6ff5f14",
                  "suggested_bibs": "Suggested_bib_1",
                  "bib": "Bib_1",
                  "created_at": "2017-12-22T01:52:47.915+01:00",
                  "updated_at": "2017-12-22T01:52:47.915+01:00",
                  "image_file_name": "test_1.jpg",
                  "image_content_type": "image/jpg",
                  "image_file_size": 19024,
                  "image_updated_at": "2017-12-22T01:52:47.000+01:00",
                  "edition_id": 2230
                }
              }
            ]

+ Request return its list of photos
**GET**&nbsp;&nbsp;`/api/v1/editions/2231/photos`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Obtenir une photo [GET /api/v1/photos/{id}]

+ Parameters
    + id: `c4c7e2e3-060c-4b2d-8e2f-cb7080e5952a` (string, required)

+ Request return the photo
**GET**&nbsp;&nbsp;`/api/v1/photos/c4c7e2e3-060c-4b2d-8e2f-cb7080e5952a`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "c4c7e2e3-060c-4b2d-8e2f-cb7080e5952a",
              "race_id": "dade8fed-ec4a-4305-a4f2-c1b0952306a6",
              "suggested_bibs": "Suggested_bib_3",
              "bib": "Bib_3",
              "created_at": "2017-12-22T01:52:47.957+01:00",
              "updated_at": "2017-12-22T01:52:47.957+01:00",
              "image_file_name": "test_3.jpg",
              "image_content_type": "image/jpg",
              "image_file_size": 19024,
              "image_updated_at": "2017-12-22T01:52:47.000+01:00",
              "edition_id": 2234
            }

+ Request return Not found
**GET**&nbsp;&nbsp;`/api/v1/photos/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Ajouter une photo à une course ou à une édition [POST /api/v1/races/{race_id}/photos]

+ Parameters
    + race_id: `8e7c1900-b7a6-44bc-8a75-e25439409640` (string, required)

+ Request create a new photo
**POST**&nbsp;&nbsp;`/api/v1/races/8e7c1900-b7a6-44bc-8a75-e25439409640/photos`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "photo": {
                "suggested_bibs": "Suggested_bib_6",
                "bib": "Bib_6",
                "image_file_name": "test_6.jpg",
                "image_content_type": "image/jpg",
                "image_file_size": 19024,
                "image_updated_at": "2017-12-22T00:52:47+00:00"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "b32a7198-2d33-43fb-b150-f8228c544e09",
              "race_id": "8e7c1900-b7a6-44bc-8a75-e25439409640",
              "suggested_bibs": "Suggested_bib_6",
              "bib": "Bib_6",
              "created_at": "2017-12-22T01:52:47.999+01:00",
              "updated_at": "2017-12-22T01:52:47.999+01:00",
              "image_file_name": "test_6.jpg",
              "image_content_type": "image/jpg",
              "image_file_size": 19024,
              "image_updated_at": "2017-12-22T01:52:47.000+01:00",
              "edition_id": null
            }

+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/races/19468168-79e8-481e-8fe6-1f1b34cdbaeb/photos`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



+ Request create a new photo
**POST**&nbsp;&nbsp;`/api/v1/editions/2241/photos`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "photo": {
                "suggested_bibs": "Suggested_bib_9",
                "bib": "Bib_9",
                "image_file_name": "test_9.jpg",
                "image_content_type": "image/jpg",
                "image_file_size": 19024,
                "image_updated_at": "2017-12-22T00:52:48+00:00"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "89fca912-14d8-4fb9-ab53-8a46aab994a4",
              "race_id": null,
              "suggested_bibs": "Suggested_bib_9",
              "bib": "Bib_9",
              "created_at": "2017-12-22T01:52:48.043+01:00",
              "updated_at": "2017-12-22T01:52:48.043+01:00",
              "image_file_name": "test_9.jpg",
              "image_content_type": "image/jpg",
              "image_file_size": 19024,
              "image_updated_at": "2017-12-22T01:52:48.000+01:00",
              "edition_id": 2241
            }

+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/editions/2243/photos`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Mettre à jour une photo [PUT /api/v1/photos/{id}]

+ Parameters
    + id: `39276176-bacb-4a75-8a6b-0b5e342eec79` (string, required)

+ Request return Success
**PUT**&nbsp;&nbsp;`/api/v1/photos/39276176-bacb-4a75-8a6b-0b5e342eec79`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "photo": {
                "suggested_bibs": "Suggested_bib_12",
                "bib": "Bib_12",
                "image_file_name": "test_12.jpg",
                "image_content_type": "image/jpg",
                "image_file_size": 19024,
                "image_updated_at": "2017-12-22T00:52:48+00:00"
              }
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "39276176-bacb-4a75-8a6b-0b5e342eec79",
              "suggested_bibs": "Suggested_bib_12",
              "bib": "Bib_12",
              "image_file_name": "test_12.jpg",
              "image_content_type": "image/jpg",
              "image_file_size": 19024,
              "image_updated_at": "2017-12-22T01:52:48.000+01:00",
              "edition_id": 2246,
              "race_id": "5a6c7861-1e2c-4c9a-af64-4cfd0583c500",
              "created_at": "2017-12-22T01:52:48.085+01:00",
              "updated_at": "2017-12-22T01:52:48.091+01:00"
            }

+ Request return Bad request
**PUT**&nbsp;&nbsp;`/api/v1/photos/af4467e7-08f9-4af4-89d0-d820e8229a9e`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "photo": null
            }

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Supprimer une photo [DELETE /api/v1/photos/{id}]

+ Parameters
    + id: `77c35d3e-0b8a-4811-8858-d5c3dd2da38b` (string, required)

+ Request return No content
**DELETE**&nbsp;&nbsp;`/api/v1/photos/77c35d3e-0b8a-4811-8858-d5c3dd2da38b`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 204

    + Body



+ Request return Not Found
**DELETE**&nbsp;&nbsp;`/api/v1/photos/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



## Courses [/races]
Une course contient plusieurs résultats.

### Obtenir toutes les courses d'une édition [GET /api/v1/editions/{edition_id}/races]

+ Parameters
    + edition_id: `2253` (number, required)

+ Request return a list of races for an edition
**GET**&nbsp;&nbsp;`/api/v1/editions/2253/races`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            [
              {
                "name": "Race_13",
                "date": "2017-12-22",
                "email_sender": "contact@race_13.com",
                "hashtag": "#HASH13",
                "results_url": "results_13.com",
                "sms_message": "Congratulation for Race13",
                "template": "Template_13",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race13.com",
                "external_link_button": "Button_race13.com",
                "created_at": "2017-12-22T01:52:48.213+01:00",
                "updated_at": "2017-12-22T01:52:48.213+01:00",
                "raw_results_file_name": "raw_Race13",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race13",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null,
                "coef": 13,
                "category": "Category_13",
                "department": "Department_13",
                "edition": {
                  "date": "2017-12-22",
                  "description": "Desc_41",
                  "email_sender": "contact@race_41.com",
                  "hashtag": "#HASH41",
                  "results_url": "results_41.com",
                  "sms_message": "Congratulation for Race41",
                  "template": "Template_39",
                  "widget_generated_at": null,
                  "photos_widget_generated_at": null,
                  "external_link": "Race41.com",
                  "external_link_button": "Button_race41.com",
                  "created_at": "2017-12-22T01:52:48.211+01:00",
                  "updated_at": "2017-12-22T01:52:48.211+01:00",
                  "raw_results_file_name": "raw_Race41",
                  "raw_results_content_type": "text/csv",
                  "raw_results_file_size": 19024,
                  "raw_results_updated_at": null,
                  "background_image_file_name": "raw_Race41",
                  "background_image_content_type": "image/jpg",
                  "background_image_file_size": 19024,
                  "background_image_updated_at": null
                }
              }
            ]

### Obtenir une course [GET /api/v1/races/{id}]

+ Parameters
    + id: `08a636b8-d3fe-409c-989b-58a08748ee4d` (string, required)

+ Request return the race
**GET**&nbsp;&nbsp;`/api/v1/races/08a636b8-d3fe-409c-989b-58a08748ee4d`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "name": "Race_14",
              "date": "2017-12-22",
              "email_sender": "contact@race_14.com",
              "hashtag": "#HASH14",
              "results_url": "results_14.com",
              "sms_message": "Congratulation for Race14",
              "template": "Template_14",
              "widget_generated_at": null,
              "photos_widget_generated_at": null,
              "external_link": "Race14.com",
              "external_link_button": "Button_race14.com",
              "created_at": "2017-12-22T01:52:48.231+01:00",
              "updated_at": "2017-12-22T01:52:48.231+01:00",
              "raw_results_file_name": "raw_Race14",
              "raw_results_content_type": "text/csv",
              "raw_results_file_size": 19024,
              "raw_results_updated_at": null,
              "background_image_file_name": "raw_Race14",
              "background_image_content_type": "image/jpg",
              "background_image_file_size": 19024,
              "background_image_updated_at": null,
              "coef": 14,
              "category": "Category_14",
              "department": "Department_14",
              "edition": {
                "date": "2017-12-22",
                "description": "Desc_42",
                "email_sender": "contact@race_42.com",
                "hashtag": "#HASH42",
                "results_url": "results_42.com",
                "sms_message": "Congratulation for Race42",
                "template": "Template_40",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race42.com",
                "external_link_button": "Button_race42.com",
                "created_at": "2017-12-22T01:52:48.229+01:00",
                "updated_at": "2017-12-22T01:52:48.229+01:00",
                "raw_results_file_name": "raw_Race42",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race42",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null
              }
            }

+ Request return Not found
**GET**&nbsp;&nbsp;`/api/v1/races/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Ajouter une course à une édition [POST /api/v1/editions/{edition_id}/races]

+ Parameters
    + edition_id: `2256` (number, required)

+ Request create a new race for an edition
**POST**&nbsp;&nbsp;`/api/v1/editions/2256/races`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "race": {
                "name": "Race_17",
                "email_sender": "contact@race_17.com",
                "email_name": "Race_17",
                "date": "2017-12-22T00:52:48+00:00",
                "hashtag": "#HASH17",
                "results_url": "results_17.com",
                "sms_message": "Congratulation for Race17",
                "raw_results_file_name": "raw_Race17",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "background_image_file_name": "raw_Race17",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "template": "Template_17",
                "external_link": "Race17.com",
                "external_link_button": "Button_race17.com",
                "coef": "17",
                "category": "Category_17",
                "department": "Department_17"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "name": "Race_17",
              "date": "2017-12-22",
              "email_sender": "contact@race_17.com",
              "hashtag": "#HASH17",
              "results_url": "results_17.com",
              "sms_message": "Congratulation for Race17",
              "template": "Template_17",
              "widget_generated_at": null,
              "photos_widget_generated_at": null,
              "external_link": "Race17.com",
              "external_link_button": "Button_race17.com",
              "created_at": "2017-12-22T01:52:48.259+01:00",
              "updated_at": "2017-12-22T01:52:48.259+01:00",
              "raw_results_file_name": "raw_Race17",
              "raw_results_content_type": "text/csv",
              "raw_results_file_size": 19024,
              "raw_results_updated_at": null,
              "background_image_file_name": "raw_Race17",
              "background_image_content_type": "image/jpg",
              "background_image_file_size": 19024,
              "background_image_updated_at": null,
              "coef": 17,
              "category": "Category_17",
              "department": "Department_17",
              "edition": {
                "date": "2017-12-22",
                "description": "Desc_44",
                "email_sender": "contact@race_44.com",
                "hashtag": "#HASH44",
                "results_url": "results_44.com",
                "sms_message": "Congratulation for Race44",
                "template": "Template_42",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race44.com",
                "external_link_button": "Button_race44.com",
                "created_at": "2017-12-22T01:52:48.251+01:00",
                "updated_at": "2017-12-22T01:52:48.251+01:00",
                "raw_results_file_name": "raw_Race44",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race44",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null
              }
            }

+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/editions/2257/races`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Mettre à jour une course [PUT /api/v1/races/{id}]

+ Parameters
    + id: `42afee79-9fc7-463f-9b7f-fa99b6d76500` (string, required)

+ Request return Success
**PUT**&nbsp;&nbsp;`/api/v1/races/42afee79-9fc7-463f-9b7f-fa99b6d76500`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "race": {
                "name": "Race_20",
                "email_sender": "contact@race_20.com",
                "email_name": "Race_20",
                "date": "2017-12-22T00:52:48+00:00",
                "hashtag": "#HASH20",
                "results_url": "results_20.com",
                "sms_message": "Congratulation for Race20",
                "raw_results_file_name": "raw_Race20",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "background_image_file_name": "raw_Race20",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "template": "Template_20",
                "external_link": "Race20.com",
                "external_link_button": "Button_race20.com",
                "coef": "20",
                "category": "Category_20",
                "department": "Department_20"
              }
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "name": "Race_20",
              "date": "2017-12-22",
              "email_sender": "contact@race_20.com",
              "hashtag": "#HASH20",
              "results_url": "results_20.com",
              "sms_message": "Congratulation for Race20",
              "template": "Template_20",
              "widget_generated_at": null,
              "photos_widget_generated_at": null,
              "external_link": "Race20.com",
              "external_link_button": "Button_race20.com",
              "created_at": "2017-12-22T01:52:48.280+01:00",
              "updated_at": "2017-12-22T01:52:48.287+01:00",
              "raw_results_file_name": "raw_Race20",
              "raw_results_content_type": "text/csv",
              "raw_results_file_size": 19024,
              "raw_results_updated_at": null,
              "background_image_file_name": "raw_Race20",
              "background_image_content_type": "image/jpg",
              "background_image_file_size": 19024,
              "background_image_updated_at": null,
              "coef": 20,
              "category": "Category_20",
              "department": "Department_20",
              "edition": {
                "date": "2017-12-22",
                "description": "Desc_46",
                "email_sender": "contact@race_46.com",
                "hashtag": "#HASH46",
                "results_url": "results_46.com",
                "sms_message": "Congratulation for Race46",
                "template": "Template_44",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race46.com",
                "external_link_button": "Button_race46.com",
                "created_at": "2017-12-22T01:52:48.278+01:00",
                "updated_at": "2017-12-22T01:52:48.278+01:00",
                "raw_results_file_name": "raw_Race46",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race46",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null
              }
            }

+ Request return Bad request
**PUT**&nbsp;&nbsp;`/api/v1/races/d1364306-1e6d-4c02-95ab-533bdaa21f5f`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "race": null
            }

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Supprimer une course [DELETE /api/v1/races/{id}]

+ Parameters
    + id: `3d1ac9eb-b4e1-4971-afca-4736c922b22c` (string, required)

+ Request return No content
**DELETE**&nbsp;&nbsp;`/api/v1/races/3d1ac9eb-b4e1-4971-afca-4736c922b22c`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 204

    + Body



+ Request return Not Found
**DELETE**&nbsp;&nbsp;`/api/v1/races/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



## Résultats [/results]
Résultat d'un coureur pour une course donnée. Attention ! Les résultats peuvent être associés à des coureurs qui ne sont pas dans la base coureurs !

### Obtenir toutes les résultats d'une course, d'une édition ou d'un coureur [GET /api/v1/races/{race_id}/results]

+ Parameters
    + race_id: `abb2a7a0-7641-43dc-a008-5a3ee747851d` (string, required)

+ Request return its list of results
**GET**&nbsp;&nbsp;`/api/v1/races/abb2a7a0-7641-43dc-a008-5a3ee747851d/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            [
              {
                "phone": "+3311111111",
                "mail": "contact@1.com",
                "rank": 1,
                "name": "Result_1",
                "country": "FR",
                "bib": "Bib_1",
                "categ_rank": 1,
                "categ": "Categ_1",
                "sex_rank": 1,
                "time": "1'1''1'",
                "speed": "1km/h",
                "message": "Congrats ! 1",
                "race_detail": "Race 1",
                "created_at": "2017-12-22T01:52:48.364+01:00",
                "updated_at": "2017-12-22T01:52:48.364+01:00",
                "uploaded_at": null,
                "diploma_generated_at": null,
                "email_sent_at": null,
                "sms_sent_at": null,
                "diploma_url": "www.result_1.com",
                "points": 1,
                "first_name": "First_1",
                "last_name": "Last_1",
                "dob": "2017-12-22T01:52:48.000+01:00",
                "race": {
                  "name": "Race_24",
                  "date": "2017-12-22",
                  "email_sender": "contact@race_24.com",
                  "hashtag": "#HASH24",
                  "results_url": "results_24.com",
                  "sms_message": "Congratulation for Race24",
                  "template": "Template_24",
                  "widget_generated_at": null,
                  "photos_widget_generated_at": null,
                  "external_link": "Race24.com",
                  "external_link_button": "Button_race24.com",
                  "created_at": "2017-12-22T01:52:48.338+01:00",
                  "updated_at": "2017-12-22T01:52:48.338+01:00",
                  "raw_results_file_name": "raw_Race24",
                  "raw_results_content_type": "text/csv",
                  "raw_results_file_size": 19024,
                  "raw_results_updated_at": null,
                  "background_image_file_name": "raw_Race24",
                  "background_image_content_type": "image/jpg",
                  "background_image_file_size": 19024,
                  "background_image_updated_at": null,
                  "coef": 24,
                  "category": "Category_24",
                  "department": "Department_24"
                },
                "edition": null,
                "runner": {
                  "id_key": "ID_1",
                  "first_name": "First_1",
                  "last_name": "Last_1",
                  "dob": "2017-11-16T11:05:06.000+01:00",
                  "department": "40",
                  "sex": "M",
                  "created_at": "2017-12-22T01:52:48.348+01:00",
                  "updated_at": "2017-12-22T01:52:48.348+01:00"
                }
              }
            ]

+ Request return its list of results
**GET**&nbsp;&nbsp;`/api/v1/runners/975/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            [
              {
                "phone": "+3322222222",
                "mail": "contact@2.com",
                "rank": 2,
                "name": "Result_2",
                "country": "FR",
                "bib": "Bib_2",
                "categ_rank": 2,
                "categ": "Categ_2",
                "sex_rank": 2,
                "time": "2'2''2'",
                "speed": "2km/h",
                "message": "Congrats ! 2",
                "race_detail": "Race 2",
                "created_at": "2017-12-22T01:52:48.396+01:00",
                "updated_at": "2017-12-22T01:52:48.396+01:00",
                "uploaded_at": null,
                "diploma_generated_at": null,
                "email_sent_at": null,
                "sms_sent_at": null,
                "diploma_url": "www.result_2.com",
                "points": 2,
                "first_name": "First_2",
                "last_name": "Last_2",
                "dob": "2017-12-22T01:52:48.000+01:00",
                "race": {
                  "name": "Race_25",
                  "date": "2017-12-22",
                  "email_sender": "contact@race_25.com",
                  "hashtag": "#HASH25",
                  "results_url": "results_25.com",
                  "sms_message": "Congratulation for Race25",
                  "template": "Template_25",
                  "widget_generated_at": null,
                  "photos_widget_generated_at": null,
                  "external_link": "Race25.com",
                  "external_link_button": "Button_race25.com",
                  "created_at": "2017-12-22T01:52:48.391+01:00",
                  "updated_at": "2017-12-22T01:52:48.391+01:00",
                  "raw_results_file_name": "raw_Race25",
                  "raw_results_content_type": "text/csv",
                  "raw_results_file_size": 19024,
                  "raw_results_updated_at": null,
                  "background_image_file_name": "raw_Race25",
                  "background_image_content_type": "image/jpg",
                  "background_image_file_size": 19024,
                  "background_image_updated_at": null,
                  "coef": 25,
                  "category": "Category_25",
                  "department": "Department_25"
                },
                "edition": null,
                "runner": {
                  "id_key": "ID_2",
                  "first_name": "First_2",
                  "last_name": "Last_2",
                  "dob": "2017-11-16T11:05:06.000+01:00",
                  "department": "40",
                  "sex": "M",
                  "created_at": "2017-12-22T01:52:48.394+01:00",
                  "updated_at": "2017-12-22T01:52:48.394+01:00"
                }
              }
            ]

+ Request return its list of results
**GET**&nbsp;&nbsp;`/api/v1/editions/2264/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Obtenir un résultat [GET /api/v1/results/{id}]

+ Parameters
    + id: `f965e5f3-1c8a-4547-90c3-ecb1483bbc1a` (string, required)

+ Request return the result
**GET**&nbsp;&nbsp;`/api/v1/results/f965e5f3-1c8a-4547-90c3-ecb1483bbc1a`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "phone": "+3344444444",
              "mail": "contact@4.com",
              "rank": 4,
              "name": "Result_4",
              "country": "FR",
              "bib": "Bib_4",
              "categ_rank": 4,
              "categ": "Categ_4",
              "sex_rank": 4,
              "time": "4'4''4'",
              "speed": "4km/h",
              "message": "Congrats ! 4",
              "race_detail": "Race 4",
              "created_at": "2017-12-22T01:52:48.435+01:00",
              "updated_at": "2017-12-22T01:52:48.435+01:00",
              "uploaded_at": null,
              "diploma_generated_at": null,
              "email_sent_at": null,
              "sms_sent_at": null,
              "diploma_url": "www.result_4.com",
              "points": 4,
              "first_name": "First_4",
              "last_name": "Last_4",
              "dob": "2017-12-22T01:52:48.000+01:00",
              "race": {
                "name": "Race_27",
                "date": "2017-12-22",
                "email_sender": "contact@race_27.com",
                "hashtag": "#HASH27",
                "results_url": "results_27.com",
                "sms_message": "Congratulation for Race27",
                "template": "Template_27",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race27.com",
                "external_link_button": "Button_race27.com",
                "created_at": "2017-12-22T01:52:48.430+01:00",
                "updated_at": "2017-12-22T01:52:48.430+01:00",
                "raw_results_file_name": "raw_Race27",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race27",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null,
                "coef": 27,
                "category": "Category_27",
                "department": "Department_27"
              },
              "edition": null,
              "runner": {
                "id_key": "ID_4",
                "first_name": "First_4",
                "last_name": "Last_4",
                "dob": "2017-11-16T11:05:06.000+01:00",
                "department": "40",
                "sex": "M",
                "created_at": "2017-12-22T01:52:48.433+01:00",
                "updated_at": "2017-12-22T01:52:48.433+01:00"
              }
            }

+ Request return Not found
**GET**&nbsp;&nbsp;`/api/v1/results/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Ajouter un résultat à une course, une édition ou un coureur [POST /api/v1/races/{race_id}/results]

+ Parameters
    + race_id: `c75aa02d-9202-41b9-beb2-d13afa007b31` (string, required)

+ Request create a new result
**POST**&nbsp;&nbsp;`/api/v1/races/c75aa02d-9202-41b9-beb2-d13afa007b31/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "result": {
                "name": "Result_7",
                "phone": "+3377777777",
                "mail": "contact@7.com",
                "rank": "7",
                "country": "FR",
                "bib": "Bib_7",
                "categ_rank": "7",
                "categ": "Categ_7",
                "sex_rank": "7",
                "sex": "M",
                "time": "7'7''7'",
                "speed": "7km/h",
                "message": "Congrats ! 7",
                "race_detail": "Race 7",
                "diploma_url": "www.result_7.com",
                "points": "7",
                "first_name": "First_7",
                "last_name": "Last_7",
                "dob": "2017-12-22T00:52:48+00:00"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "phone": "+3377777777",
              "mail": "contact@7.com",
              "rank": null,
              "name": "Result_7",
              "country": "FR",
              "bib": "Bib_7",
              "categ_rank": 7,
              "categ": "Categ_7",
              "sex_rank": 7,
              "time": "7'7''7'",
              "speed": "7km/h",
              "message": "Congrats ! 7",
              "race_detail": "Race 7",
              "created_at": "2017-12-22T01:52:48.482+01:00",
              "updated_at": "2017-12-22T01:52:48.482+01:00",
              "uploaded_at": null,
              "diploma_generated_at": null,
              "email_sent_at": null,
              "sms_sent_at": null,
              "diploma_url": "www.result_7.com",
              "points": 7,
              "first_name": "First_7",
              "last_name": "Last_7",
              "dob": "2017-12-22T01:52:48.000+01:00",
              "race": {
                "name": "Race_29",
                "date": "2017-12-22",
                "email_sender": "contact@race_29.com",
                "hashtag": "#HASH29",
                "results_url": "results_29.com",
                "sms_message": "Congratulation for Race29",
                "template": "Template_29",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race29.com",
                "external_link_button": "Button_race29.com",
                "created_at": "2017-12-22T01:52:48.468+01:00",
                "updated_at": "2017-12-22T01:52:48.468+01:00",
                "raw_results_file_name": "raw_Race29",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race29",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null,
                "coef": 29,
                "category": "Category_29",
                "department": "Department_29"
              },
              "edition": null,
              "runner": null
            }

+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/races/67348b79-f70d-4e8e-80dc-4f8ccc809b62/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



+ Request create a new result
**POST**&nbsp;&nbsp;`/api/v1/runners/981/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "result": {
                "name": "Result_10",
                "phone": "+331010101010101010",
                "mail": "contact@10.com",
                "rank": "10",
                "country": "FR",
                "bib": "Bib_10",
                "categ_rank": "10",
                "categ": "Categ_10",
                "sex_rank": "10",
                "sex": "M",
                "time": "10'10''10'",
                "speed": "10km/h",
                "message": "Congrats ! 10",
                "race_detail": "Race 10",
                "diploma_url": "www.result_10.com",
                "points": "10",
                "first_name": "First_10",
                "last_name": "Last_10",
                "dob": "2017-12-22T00:52:48+00:00"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "phone": "+331010101010101010",
              "mail": "contact@10.com",
              "rank": null,
              "name": "Result_10",
              "country": "FR",
              "bib": "Bib_10",
              "categ_rank": 10,
              "categ": "Categ_10",
              "sex_rank": 10,
              "time": "10'10''10'",
              "speed": "10km/h",
              "message": "Congrats ! 10",
              "race_detail": "Race 10",
              "created_at": "2017-12-22T01:52:48.535+01:00",
              "updated_at": "2017-12-22T01:52:48.535+01:00",
              "uploaded_at": null,
              "diploma_generated_at": null,
              "email_sent_at": null,
              "sms_sent_at": null,
              "diploma_url": "www.result_10.com",
              "points": 10,
              "first_name": "First_10",
              "last_name": "Last_10",
              "dob": "2017-12-22T01:52:48.000+01:00",
              "race": null,
              "edition": null,
              "runner": {
                "id_key": "ID_8",
                "first_name": "First_8",
                "last_name": "Last_8",
                "dob": "2017-11-16T11:05:06.000+01:00",
                "department": "40",
                "sex": "M",
                "created_at": "2017-12-22T01:52:48.525+01:00",
                "updated_at": "2017-12-22T01:52:48.525+01:00"
              }
            }

+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/runners/982/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



+ Request create a new result
**POST**&nbsp;&nbsp;`/api/v1/editions/2271/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "result": {
                "name": "Result_13",
                "phone": "+331313131313131313",
                "mail": "contact@13.com",
                "rank": "13",
                "country": "FR",
                "bib": "Bib_13",
                "categ_rank": "13",
                "categ": "Categ_13",
                "sex_rank": "13",
                "sex": "M",
                "time": "13'13''13'",
                "speed": "13km/h",
                "message": "Congrats ! 13",
                "race_detail": "Race 13",
                "diploma_url": "www.result_13.com",
                "points": "13",
                "first_name": "First_13",
                "last_name": "Last_13",
                "dob": "2017-12-22T00:52:48+00:00"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "phone": "+331313131313131313",
              "mail": "contact@13.com",
              "rank": null,
              "name": "Result_13",
              "country": "FR",
              "bib": "Bib_13",
              "categ_rank": 13,
              "categ": "Categ_13",
              "sex_rank": 13,
              "time": "13'13''13'",
              "speed": "13km/h",
              "message": "Congrats ! 13",
              "race_detail": "Race 13",
              "created_at": "2017-12-22T01:52:48.583+01:00",
              "updated_at": "2017-12-22T01:52:48.583+01:00",
              "uploaded_at": null,
              "diploma_generated_at": null,
              "email_sent_at": null,
              "sms_sent_at": null,
              "diploma_url": "www.result_13.com",
              "points": 13,
              "first_name": "First_13",
              "last_name": "Last_13",
              "dob": "2017-12-22T01:52:48.000+01:00",
              "race": null,
              "edition": {
                "date": "2017-12-22",
                "description": "Desc_59",
                "email_sender": "contact@race_59.com",
                "hashtag": "#HASH59",
                "results_url": "results_59.com",
                "sms_message": "Congratulation for Race59",
                "template": "Template_57",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race59.com",
                "external_link_button": "Button_race59.com",
                "created_at": "2017-12-22T01:52:48.565+01:00",
                "updated_at": "2017-12-22T01:52:48.565+01:00",
                "raw_results_file_name": "raw_Race59",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race59",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null
              },
              "runner": null
            }

+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/editions/2272/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Mettre à jour un résultat [PUT /api/v1/results/{id}]

+ Parameters
    + id: `93a09245-b0f5-4d75-b16f-0973635a274f` (string, required)

+ Request return Success
**PUT**&nbsp;&nbsp;`/api/v1/results/93a09245-b0f5-4d75-b16f-0973635a274f`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "result": {
                "name": "Result_16",
                "phone": "+331616161616161616",
                "mail": "contact@16.com",
                "rank": "16",
                "country": "FR",
                "bib": "Bib_16",
                "categ_rank": "16",
                "categ": "Categ_16",
                "sex_rank": "16",
                "sex": "M",
                "time": "16'16''16'",
                "speed": "16km/h",
                "message": "Congrats ! 16",
                "race_detail": "Race 16",
                "diploma_url": "www.result_16.com",
                "points": "16",
                "first_name": "First_16",
                "last_name": "Last_16",
                "dob": "2017-12-22T00:52:48+00:00"
              }
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "phone": "+331616161616161616",
              "mail": "contact@16.com",
              "rank": 15,
              "name": "Result_16",
              "country": "FR",
              "bib": "Bib_16",
              "categ_rank": 16,
              "categ": "Categ_16",
              "sex_rank": 16,
              "time": "16'16''16'",
              "speed": "16km/h",
              "message": "Congrats ! 16",
              "race_detail": "Race 16",
              "created_at": "2017-12-22T01:52:48.622+01:00",
              "updated_at": "2017-12-22T01:52:48.629+01:00",
              "uploaded_at": null,
              "diploma_generated_at": null,
              "email_sent_at": null,
              "sms_sent_at": null,
              "diploma_url": "www.result_16.com",
              "points": 16,
              "first_name": "First_16",
              "last_name": "Last_16",
              "dob": "2017-12-22T01:52:48.000+01:00",
              "race": {
                "name": "Race_35",
                "date": "2017-12-22",
                "email_sender": "contact@race_35.com",
                "hashtag": "#HASH35",
                "results_url": "results_35.com",
                "sms_message": "Congratulation for Race35",
                "template": "Template_35",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race35.com",
                "external_link_button": "Button_race35.com",
                "created_at": "2017-12-22T01:52:48.614+01:00",
                "updated_at": "2017-12-22T01:52:48.614+01:00",
                "raw_results_file_name": "raw_Race35",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race35",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null,
                "coef": 35,
                "category": "Category_35",
                "department": "Department_35"
              },
              "edition": null,
              "runner": {
                "id_key": "ID_12",
                "first_name": "First_12",
                "last_name": "Last_12",
                "dob": "2017-11-16T11:05:06.000+01:00",
                "department": "40",
                "sex": "M",
                "created_at": "2017-12-22T01:52:48.620+01:00",
                "updated_at": "2017-12-22T01:52:48.620+01:00"
              }
            }

+ Request return Bad request
**PUT**&nbsp;&nbsp;`/api/v1/results/9f083924-f878-4577-a8f6-eff6e7d5a5e7`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "result": null
            }

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Supprimer un résultat [DELETE /api/v1/results/{id}]

+ Parameters
    + id: `5f0131de-a0b3-497a-93c8-264c6311edb9` (string, required)

+ Request return No content
**DELETE**&nbsp;&nbsp;`/api/v1/results/5f0131de-a0b3-497a-93c8-264c6311edb9`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 204

    + Body



+ Request return Not Found
**DELETE**&nbsp;&nbsp;`/api/v1/results/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



# Group API des coureurs


## Coureur [/runner]
Un coureur possède plusieurs résultats de courses et plusieurs photos.

### Obtenir tous les coureurs [GET /api/v1/runners]


+ Request return a list of runners
**GET**&nbsp;&nbsp;`/api/v1/runners`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            [
              {
                "id_key": "ID_16",
                "first_name": "First_16",
                "last_name": "Last_16",
                "dob": "2017-11-16T11:05:06.000+01:00",
                "department": "40",
                "sex": "M",
                "created_at": "2017-12-22T01:52:48.703+01:00",
                "updated_at": "2017-12-22T01:52:48.703+01:00"
              }
            ]

### Obtenir un coureur [GET /api/v1/runners/{id}]

+ Parameters
    + id: `990` (number, required)

+ Request return the runner
**GET**&nbsp;&nbsp;`/api/v1/runners/990`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id_key": "ID_17",
              "first_name": "First_17",
              "last_name": "Last_17",
              "dob": "2017-11-16T11:05:06.000+01:00",
              "department": "40",
              "sex": "M",
              "created_at": "2017-12-22T01:52:48.712+01:00",
              "updated_at": "2017-12-22T01:52:48.712+01:00"
            }

+ Request return Not found
**GET**&nbsp;&nbsp;`/api/v1/runners/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Ajouter une coureur [POST /api/v1/runners]


+ Request create a new runner
**POST**&nbsp;&nbsp;`/api/v1/runners`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "runner": {
                "id_key": "ID_20",
                "first_name": "First_20",
                "last_name": "Last_20",
                "dob": "2017-11-16 11:05:06",
                "department": "40",
                "sex": "M"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id_key": "ID_20",
              "first_name": "First_20",
              "last_name": "Last_20",
              "dob": "2017-11-16T11:05:06.000+01:00",
              "department": "40",
              "sex": "M",
              "created_at": "2017-12-22T01:52:48.731+01:00",
              "updated_at": "2017-12-22T01:52:48.731+01:00"
            }

+ Request return Unprocessable entity
**POST**&nbsp;&nbsp;`/api/v1/runners`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "runner": {
                "id_key": "ID_22",
                "first_name": "",
                "last_name": "Last_22",
                "dob": "2017-11-16 11:05:06",
                "department": "40",
                "sex": "M"
              }
            }

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/runners`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Mettre à jour un coureur [PUT /api/v1/runners/{id}]

+ Parameters
    + id: `996` (number, required)

+ Request return Success
**PUT**&nbsp;&nbsp;`/api/v1/runners/996`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "runner": {
                "id_key": "ID_25",
                "first_name": "First_24",
                "last_name": "Last_25",
                "dob": "2017-11-16 11:05:06",
                "department": "40",
                "sex": "M"
              }
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id_key": "ID_25",
              "first_name": "First_24",
              "last_name": "Last_25",
              "dob": "2017-11-16T11:05:06.000+01:00",
              "department": "40",
              "sex": "M",
              "created_at": "2017-12-22T01:52:48.753+01:00",
              "updated_at": "2017-12-22T01:52:48.758+01:00"
            }

+ Request return Not Modified
**PUT**&nbsp;&nbsp;`/api/v1/runners/997`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "runner": {
                "id_key": "ID_27",
                "first_name": "",
                "last_name": "Last_27",
                "dob": "2017-11-16 11:05:06",
                "department": "40",
                "sex": "M"
              }
            }

+ Response 304

    + Body



+ Request return Bad request
**PUT**&nbsp;&nbsp;`/api/v1/runners/998`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "runner": null
            }

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Supprimer une coureur [DELETE /api/v1/runners/{id}]

+ Parameters
    + id: `999` (number, required)

+ Request return No content
**DELETE**&nbsp;&nbsp;`/api/v1/runners/999`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 204

    + Body



+ Request return Not Found
**DELETE**&nbsp;&nbsp;`/api/v1/runners/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body


