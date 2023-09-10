import pandas as pd

from app.config.columns.calc_output_columns import CalcOutputColumns

TRUE_VALUE = 1.0


def calc_relational_error_rate(
    true: float,
    actual: float,
) -> float:
    return abs((true - actual) / true)


def calc_relations_error_rates(
    widths: list[float],
    heights: list[float],
    depths: list[float],
) -> list[float]:
    actual_volumes = [
        w * heights[index] * depths[index] for index, w in enumerate(widths)
    ]
    true_volumes = [TRUE_VALUE for _ in range(len(widths))]
    actual_error_rates = [
        calc_relational_error_rate(
            true=true_volumes[index],
            actual=actual_volume,
        )
        for index, actual_volume in enumerate(actual_volumes)
    ]
    return actual_error_rates


def calc_relations_error_rates_as_dataframe(
    item_ids: list[str],
    widths: list[float],
    heights: list[float],
    depths: list[float],
) -> pd.DataFrame:
    actual_error_rates = calc_relations_error_rates(
        widths=widths,
        heights=heights,
        depths=depths,
    )
    df = pd.DataFrame(columns=CalcOutputColumns.get_list())
    df[CalcOutputColumns.item_id] = item_ids
    df[CalcOutputColumns.relational_error_rate] = actual_error_rates
    df[CalcOutputColumns.true_value] = TRUE_VALUE

    return df
