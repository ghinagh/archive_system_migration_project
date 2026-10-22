import { CodingListComponent } from './coding-list.component';

describe('CodingListComponent — mouse on a disabled list', () => {
  function make(enabled: boolean) {
    const list = new CodingListComponent();
    list.labels = ['أ', 'ب', 'ج'];
    list.enabled = enabled;
    const selected: number[] = [];
    const dbl: number[] = [];
    const disabled: { index: number; dbl: boolean }[] = [];
    list.selectIndex.subscribe(i => selected.push(i));
    list.rowDblClick.subscribe(i => dbl.push(i));
    list.disabledRowActivate.subscribe(e => disabled.push(e));
    return { list, selected, dbl, disabled };
  }

  it('an enabled list selects and drills as before, and reports nothing as disabled', () => {
    const { list, selected, dbl, disabled } = make(true);
    list.onClick(1);
    list.onDblClick(2);
    expect(selected).toEqual([1]);
    expect(dbl).toEqual([2]);
    expect(disabled).toEqual([]);
  });

  it('a disabled list does not select or drill itself; it reports the click to its owner', () => {
    const { list, selected, dbl, disabled } = make(false);
    list.onClick(1);
    list.onDblClick(1);
    expect(selected).toEqual([]);
    expect(dbl).toEqual([]);
    expect(disabled).toEqual([{ index: 1, dbl: false }, { index: 1, dbl: true }]);
  });
});
