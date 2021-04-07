/**
 * @class       : db
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Wednesday Apr 07, 2021 13:37:35 EDT
 * @description : db
 */

const sqlite3 = require('better-sqlite3')
const db = new sqlite3('./data/complete.db')

db.getRegion = function (regionId) {
  let stmt = this.prepare(`SELECT * FROM region WHERE id=${regionId}`)
  return stmt.get()
}



module.exports = db
