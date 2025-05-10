const path = require("path");
const { execSync } = require("child_process");

const globalNodeModules = execSync("npm root -g").toString().trim();


module.exports = {
  rules: {
    "spellcheck-tech-word": true,
    "preset-ja-technical-writing": {
      "sentence-length": { max: 150 },
      "no-exclamation-question-mark": false
    },
    "ja-space-around-link": {
      before: true,
      after: true
    },
    "preset-ja-spacing": {
      "ja-space-around-code": {
        before: true,
        after: true
      },
      "ja-space-between-half-and-full-width": {
        space: "always"
      }
    },
    "@textlint-ja/morpheme-match": {
      "dictionaryPathList": [path.join(globalNodeModules, "textlint-rule-ja-official-documents/lib/dictionary.js")]
    },
    "prh": {
      "rulePaths": [
        path.join(globalNodeModules, "textlint-rule-ja-official-documents/dict/prh.yml")
      ]
    }
  }
};
