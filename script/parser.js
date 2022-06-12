let fs = require("fs");

var args = process.argv.slice(2);

if (args.length < 1) {
  console.log("Usage: node parser.js <file path>");
  process.exit(1);
}

let oldLines = fs.readFileSync(args[0], "utf8").split("\r\n");

let newLines = [
  oldLines[0].match(/^(?:[^;]*;){2}(.*)/)[1] + ";month;year;delta;found",
];

for (let i = 1; i < oldLines.length - 1; i++) {
  try {
    if (i % 10000 == 0) {
      console.log(`Traitement : ${((i / oldLines.length) * 100).toFixed(2)}%`);
    }

    let matchs = oldLines[i].match(/^([^;]*);([^;]*);(.*)/);
    date1 = new Date(matchs[1]);

    let delta = "";

    if (matchs[2]) {
      delta = Math.ceil(
        (new Date(matchs[2]).getTime() - date1.getTime()) / (1000 * 3600 * 24)
      );
    }

    newLines.push(
      matchs[3] +
        ";" +
        date1.toLocaleString("en-us", { month: "short" }) +
        ";" +
        date1.getFullYear() +
        ";" +
        delta +
        ";" +
        (delta ? "true" : "false")
    );
  } catch (error) {
    console.log(
      `Erreur sur la ligne N°${i}. Elle ne sera pas insérée dans le fichier de sortie.\nErreur : ${error}`
    );
  }
}

fs.writeFileSync("out.csv", newLines.join("\n"));
