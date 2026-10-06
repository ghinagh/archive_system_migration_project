/** One DBList1 line of legacy Form8 — AUT_NAM shown, AUT_NO behind it (Text1). */
export interface AuthorCodingRow {
  number: number | null;
  name: string | null;
}

/**
 * The SQL held by Form8's MSRDC "auther" control; DBList1 always shows its rows and
 * AUTHER.Refresh re-runs it.
 *  BY_NUMBER — select * from auther order by aut_no (RecordSource)
 *  UNORDERED — select * from auther (set by the add/edit duplicate check)
 *  PREFIX    — execute serh_auther1
 *  WORD      — execute serh_auther2
 */
export type AuthorCodingQuery = 'BY_NUMBER' | 'UNORDERED' | 'PREFIX' | 'WORD';

export interface AuthorCodingListState {
  query: AuthorCodingQuery;
  text?: string;
}
