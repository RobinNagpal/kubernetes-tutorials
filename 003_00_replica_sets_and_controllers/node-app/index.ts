import { createServer, IncomingMessage, ServerResponse } from "http";
import { hostname } from "os";

const port = 3000;

let counter = 0;
const server = createServer((request: IncomingMessage, response: ServerResponse) => {
  switch (request.url) {
    case "/node-app": {
      if (request.method === "GET") {
        counter = counter + 1;
        if (counter % 4 === 0) {
          process.exit(1);
        }
        response.setHeader("Connection", "close");
        response.end(`Hello world ${counter} from ${hostname()}, from app ${process.env.APP_NAME}`);
      }

      break;
    }
    default: {
      response.statusCode = 200;
      response.end("Unknown path");
    }
  }
});

server.listen(port);
