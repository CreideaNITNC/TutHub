swift build -c release \
    && ./.build/release/Run migrate -y \
    && sh ts-compile-prod.sh \
    && sh sass-compile-prod.sh \

