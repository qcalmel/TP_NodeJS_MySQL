const app = require('express')();
const cors = require('cors');
const bodyParser = require('body-parser');


// Middlewares
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Routes

app.use('/article',require('./routes/articles'));
app.use('/article-list',require('./routes/articles-lists'));
app.use('/category',require('./routes/categories'));
app.use('/list',require('./routes/lists'));



app.listen(3000, () => console.log('server started'))