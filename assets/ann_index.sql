# table-description: 
# This table contains one row per DICOM Annotation SeriesInstanceUID 
# available from IDC, and captures basic
# metadata about the annotation series including
# SeriesInstanceUID, SeriesDescription and the annotated image series. 

SELECT
  SeriesInstanceUID, 
  # SeriesDescription does not vary across instances, so can be selected any of the values during grouping 
  ANY_VALUE(SeriesDescription) AS SeriesDescription, 
  # SeriesInstanceUID of the slide that the ANN file refers to. 
  ANY_VALUE(ReferencedSeriesSequence[SAFE_OFFSET(0)].SeriesInstanceUID) AS referencedSeriesInstanceUID 
FROM
  `bigquery-public-data.idc_current.dicom_metadata`
WHERE
  Modality='ANN'
GROUP BY 
  SeriesInstanceUID
