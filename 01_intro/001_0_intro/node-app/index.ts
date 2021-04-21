import { createServer, IncomingMessage, ServerResponse } from "http";
import { hostname } from "os";

const port = 3000;

let counter = 0;
const server = createServer((request: IncomingMessage, response: ServerResponse) => {
  switch (request.url) {
    case "/node-app": {
      if (request.method === "GET") {
        response.setHeader("Connection", "close");
        response.end(`Hello world ${counter} from ${hostname()}`);
      }
      counter = counter + 1;
      break;
    }
    default: {
      response.statusCode = 404;
      response.end("Unknown path");
    }
  }
});

server.listen(port);
