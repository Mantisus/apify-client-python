import pytest

from apify_client._statistics import Statistics


@pytest.mark.parametrize(
    ('attempts', 'expected_errors'),
    [
        ([1], [1]),
        ([1, 5], [1, 0, 0, 0, 1]),
        ([5, 1], [1, 0, 0, 0, 1]),
        ([3, 5, 1], [1, 0, 1, 0, 1]),
        ([1, 5, 3], [1, 0, 1, 0, 1]),
        ([2, 1, 2, 1, 5, 2, 1], [3, 3, 0, 0, 1]),
    ],
)
def test_add_rate_limit_error(attempts: list[int], expected_errors: list[int]) -> None:
    """Test that add_rate_limit_error correctly tracks errors for different attempt sequences."""
    stats = Statistics()
    for attempt in attempts:
        stats.add_rate_limit_error(attempt)
    assert stats.rate_limit_errors == expected_errors


def test_add_rate_limit_error_invalid_attempt() -> None:
    """Test that add_rate_limit_error raises ValueError for invalid attempt."""
    stats = Statistics()
    with pytest.raises(ValueError, match='Attempt must be greater than 0'):
        stats.add_rate_limit_error(0)


def test_statistics_initial_state() -> None:
    """Test initial state of Statistics instance."""
    stats = Statistics()
    assert stats.calls == 0
    assert stats.requests == 0
    assert stats.rate_limit_errors == []


def test_add_rate_limit_error_type_validation() -> None:
    """Test type validation in add_rate_limit_error."""
    stats = Statistics()
    with pytest.raises(TypeError):
        stats.add_rate_limit_error('1')  # type: ignore[arg-type]
