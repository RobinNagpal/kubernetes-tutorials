import { createServer, IncomingMessage, ServerResponse } from "http";
import { hostname } from "os";

const port = 8080;
const server = createServer((request: IncomingMessage, response: ServerResponse) => {
  switch (request.url) {
    case "/node-app": {
      if (request.method === "GET") {
        response.setHeader("Connection", "close");
        response.end(`Hello world from ${hostname()}`);
      }
      break;
    }
    default: {
      response.statusCode = 404;
      response.end("Unknown path");
    }
  }
});

server.listen(port);

