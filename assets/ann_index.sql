# table-description: 
# This table contains one row per DICOM Annotation (ANN) SeriesInstanceUID 
# available from IDC, and captures basic
# metadata about the annotation series including
# SeriesInstanceUID, SeriesDescription and the annotated image series. 

SELECT
  # description:
  # DICOM SeriesInstanceUID identifier of the ANN series
  SeriesInstanceUID, 
  # description:
  # unique identifier of the collection
  ANY_VALUE(collection_id) AS collection_id,
  # description:
  # Description of the DICOM annotation series 
  ANY_VALUE(SeriesDescription) AS SeriesDescription, 
  # description:
  # SeriesInstanceUID of the slide that was annotated
  ANY_VALUE(ReferencedSeriesSequence[SAFE_OFFSET(0)].SeriesInstanceUID) AS referencedSeriesInstanceUID, 
  # description:
  # DICOM StudyInstanceUID identifier of the ANN series
  ANY_VALUE(StudyInstanceUID) AS StudyInstanceUID
FROM
  `bigquery-public-data.idc_current.dicom_all`
WHERE
  Modality='ANN'
GROUP BY 
  SeriesInstanceUID
