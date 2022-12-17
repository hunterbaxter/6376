FROM haskell:8
WORKDIR /opt/tree
RUN cabal update
COPY ./tree.cabal /opt/tree/tree.cabal
RUN cabal build --only-dependencies -j4
COPY . /opt/tree
RUN cabal install
CMD ["tree"]
