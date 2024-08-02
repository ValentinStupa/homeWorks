import sentry_sdk

sentry_sdk.init(
    dsn="https://-",
    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    environment="develop",
    release="1.0",
    traces_sample_rate=1.0,
    # Set profiles_sample_rate to 1.0 to profile 100%
    # of sampled transactions.
    # We recommend adjusting this value in production.
    profiles_sample_rate=1.0,
)
if __name__ == "__main__":
    division_by_zero = 1 /0