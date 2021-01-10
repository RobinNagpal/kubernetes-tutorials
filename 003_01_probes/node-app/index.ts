import { createServer, IncomingMessage, ServerResponse } from "http";
import { appendFileSync, readFileSync, writeFileSync } from "fs";

const port = 3000;

const log = (message: string): void => {
  console.log(message);
  appendFileSync("/opt/probe_volume/logs.txt", message);
};

const readCounter = (): number => {
  const counterValue = readFileSync("/opt/probe_volume/counter.txt");
  return parseInt(counterValue.toString());
};

const writeCounter = (counter: number): void => {
  writeFileSync("/opt/probe_volume/counter.txt", counter.toString(10));
};

const respondBack = (probeName: string, counter: number, response: ServerResponse): void => {
  const message = `${probeName} called`;
  const decorated = `${new Date().toString()} - ${message}  . Counter - ${counter} \n \n`;
  log(decorated);
  response.setHeader("Connection", "close");
  response.end(decorated);
};

const notFound = (response: ServerResponse, counter: number): void => {
  response.statusCode = 404;
  log("Unknown path");
  response.end("Unknown path");
};

const notReady = (probeName: string, counter: number, response: ServerResponse): void => {
  response.statusCode = 500;
  const decorated = `${new Date().toString()} - ${probeName} Not ready  . Counter - ${counter} \n \n`;
  log(decorated);
  response.end("Not Ready");
};

const server = createServer((request: IncomingMessage, response: ServerResponse) => {
  const counter = readCounter();
  writeCounter(counter + 1);
  try {
    if (request.method === "GET") {
      switch (request.url) {
        case "/node-app": {
          respondBack("node-app", counter, response);
          break;
        }
        case "/liveness": {
          if (counter > 20) {
            respondBack("Liveness", counter, response);
          } else {
            notReady("Liveness", counter, response);
          }

          break;
        }
        case "/readiness": {
          if (counter > 30) {
            respondBack("Readiness", counter, response);
          } else {
            notReady("Readiness", counter, response);
          }
          break;
        }
        case "/startup": {
          if (counter > 7) {
            respondBack("Startup", counter, response);
          } else {
            notReady("Startup", counter, response);
          }
          break;
        }
        default: {
          notFound(response, counter);
        }
      }
    } else {
      notFound(response, counter);
    }
  } catch (e) {
    console.log(e);
  }
});

server.listen(port);
