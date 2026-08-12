const fs = require('fs');
const path  =require('path');
const fname = process.argv[2];
const class_name = fname.replace('.ts','');
const file = fs.readFileSync(path.join('./src',fname),'utf8');

const class_text = file.slice(file.indexOf('export default'));


console.log(class_text);

