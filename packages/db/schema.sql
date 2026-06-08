-- Hush off-chain DB schema

CREATE TABLE posts (
    id          BIGSERIAL PRIMARY KEY,
    lens_post_id VARCHAR(66) UNIQUE NOT NULL,  -- onchain post ID
    author      VARCHAR(42) NOT NULL,           -- wallet address
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE decibels (
    id          BIGSERIAL PRIMARY KEY,
    post_id     BIGINT NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
    voter       VARCHAR(42) NOT NULL,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(post_id, voter)                      -- one decibel per user per post
);

CREATE INDEX idx_posts_author ON posts(author);
CREATE INDEX idx_decibels_post ON decibels(post_id);

-- Materialized view for decibel counts (refresh periodically)
CREATE MATERIALIZED VIEW post_decibels AS
    SELECT post_id, COUNT(*) AS count
    FROM decibels
    GROUP BY post_id;
