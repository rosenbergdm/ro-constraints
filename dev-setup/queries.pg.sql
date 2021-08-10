SELECT
  region.id,
  target.name,
  oncprimary.name,
  concat(fractionation.description, '') || concat(fractions_min, '') || concat('-' || fractions_max, '') as fractionation,
  intent.description,
  cast(volume as float) / 100 || ' ' || vtype.description as volume,
  cast(volume_deviation as float) / 100 || ' ' || vtype2.description as volume_deviation,
  prv,
  cast(dose as float) / 100 || ' ' || dtype.description as dose,
  cast(dose_deviation as float) / 100 || ' ' || dtype2.description as dose_deviation,
  conversion,
  importance
FROM
  region
  LEFT JOIN target on region.target = target.id
  LEFT JOIN target oncprimary on region.oncprimary = target.id
  LEFT JOIN fractionation on region.fractionation = fractionation.id
  LEFT JOIN volume_type vtype on region.volume_type = vtype.id
  LEFT JOIN intent on region.intent = intent.id
  LEFT JOIN volume_type vtype2 on region.volume_deviation_type = vtype2.id
  LEFT JOIN dose_type dtype on region.dose_type = dtype.id
  LEFT JOIN dose_type dtype2 on region.dose_deviation_type = dtype2.id;


-- select */
--   concat(description, '') || concat(fractions_min, '') || concat('-' || fractions_max, '') */
-- from */
--   fractionation; */



