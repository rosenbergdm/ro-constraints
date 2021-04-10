/**
 * @class       : db
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Wednesday Apr 07, 2021 13:37:35 EDT
 * @description : db
 */

// const sqlite3 = require('better-sqlite3')
// const db = new sqlite3('./data/complete.db')

const { Client } = require('pg')
const db = new Client({
  database: 'constraints',
})
db.connect( err => {
  if (err) {
    console.error('Database connection error', err.stack)
  } else {
    console.log(`Connection to database 'constraints' successful`)
  }
})

db.getRegion = async function (regionId) {
  const { rows } = await this.query('SELECT * from region where id = $1', [regionId])
  return(rows[0])
}

db.searchRegions = async function(
  target = null,
  fractionation = null,
  intent = null,
  importance = null
) {
  var whereClause = 'WHERE region.id > 0 '
  if (target !== null) {
    whereClause += `AND target.name in ( ${"'" + target.join("', '") + "'"} ) `
  }
  if (fractionation !== null) {
    if (fractionation.every( x => typeof(x) == 'number' ) ) {
      whereClause += `AND fractions_min in (${fractionation}) `
    } else if (fractionation.length == 3 && typeof(fractionation[1]) == 'string') {
        whereClause += `AND fractions_min >= ${fractionation[0]} ` +
          ` and (fractions_max <= ${fractionation[2]} OR fractions_max is null) `
    } else {
      whereClause +=
        `AND fractionation.description in ( ${"'" + fractionation.join("', '") + "'"} ) `
    }
  }
  if (intent !== null) {
    whereClause +=
      ` AND intent.description in ( ${"'" + intent.join("', '") + "'"} ) `
  }
  if (importance !== null) {
    whereClause +=
      ` AND region.importance in ( ${"'" + importance.join("', '") + "'"} ) `
  }
  const query = `
  SELECT
      region.id,
      target.name,
      coalesce(fractionation.description, '') || coalesce(fractions_min::text, '') || coalesce('-' || fractions_max::text, '') as fractionation,
      intent.description,
      volume::float / 100 || ' ' || vtype.description as volume,
      volume_deviation::float / 100 || ' ' || vtype2.description as volume_deviation,
      prv,
      dose::float / 100 || ' ' || dtype.description as dose,
      dose_deviation::float / 100 || ' ' || dtype2.description as dose_deviation,
      conversion,
      importance
    FROM
      region
      LEFT JOIN target on region.target = target.id
      LEFT JOIN fractionation on region.fractionation = fractionation.id
      LEFT JOIN volume_type vtype on region.volume_type = vtype.id
      LEFT JOIN intent on region.intent = intent.id
      LEFT JOIN volume_type vtype2 on region.volume_deviation_type = vtype2.id
      LEFT JOIN dose_type dtype on region.dose_type = dtype.id
      LEFT JOIN dose_type dtype2 on region.dose_deviation_type = dtype.id 
    ${whereClause};`
  const { rows } = await this.query(query, [])
  return(rows);
}

db.getAllRegions = async function() {
  const rows = await db.searchRegions()
  return(rows)
}



module.exports = db
