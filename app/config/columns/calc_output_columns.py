class CalcOutputColumns:
    item_id: str = "item_id"
    relational_error_rate: str = "relational_error_rate"
    true_value: str = "true_value"

    @staticmethod
    def get_list() -> list[str]:
        return [
            CalcOutputColumns.item_id,
            CalcOutputColumns.relational_error_rate,
            CalcOutputColumns.true_value,
        ]
