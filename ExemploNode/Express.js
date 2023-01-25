const express = require('express')
const app = express()
const port = 3030

app.get('/', (req, res) => {
  res.send('Node.JS + Apache!')
})

app.listen(port, () => {
  console.log("Aplicação rodando na porta " + port)
})
