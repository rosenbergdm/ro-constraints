/**
 * @class       : views
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Wednesday Apr 07, 2021 08:05:32 EDT
 * @description : views
 */

export default class views {
}

app.get('/test2', (req, res) => {
  res.send('Test2 OK!')
  console.log('Test 2 OK!')
})

