FROM mhart/alpine-node:11 AS builder

ARG REACT_APP_ENV
ENV REACT_APP_ENV=${REACT_APP_ENV}

WORKDIR /
COPY . .
RUN npm install react-scripts -g
RUN npm install
RUN NODE_ENV=production REACT_APP_ENV=$REACT_APP_ENV npm run build

FROM mhart/alpine-node
RUN npm install serve -g --silent
WORKDIR /build
COPY --from=builder /build .
EXPOSE 5002
CMD ["serve", "-p", "5002", "-s", "."]doc