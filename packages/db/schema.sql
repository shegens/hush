-- Hush off-chain DB schema

-- ── Users & waitlist ────────────────────────
CREATE TABLE users (
    id          BIGSERIAL PRIMARY KEY,
    address     VARCHAR(42) UNIQUE NOT NULL,    -- wallet address
    status      VARCHAR(10) NOT NULL DEFAULT 'pending'
                CHECK (status IN ('pending', 'approved')),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_users_status ON users(status);

-- ── Posts ───────────────────────────────────
CREATE TABLE posts (
    id          BIGSERIAL PRIMARY KEY,
    lens_post_id VARCHAR(66) UNIQUE NOT NULL,  -- onchain post ID
    author      VARCHAR(42) NOT NULL REFERENCES users(address),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_posts_author ON posts(author);

-- ── Decibels (likes) ────────────────────────
CREATE TABLE decibels (
    id          BIGSERIAL PRIMARY KEY,
    post_id     BIGINT NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
    voter       VARCHAR(42) NOT NULL REFERENCES users(address),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(post_id, voter)                      -- one decibel per user per post
);

CREATE INDEX idx_decibels_post ON decibels(post_id);

-- Materialized view for decibel counts (refresh periodically)
CREATE MATERIALIZED VIEW post_decibels AS
    SELECT post_id, COUNT(*) AS count
    FROM decibels
    GROUP BY post_id;
