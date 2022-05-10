import type { Principal } from '@dfinity/principal';
export interface _SERVICE {
  'balanceOf' : (arg_0: Principal) => Promise<bigint>,
  'getSybmol' : () => Promise<string>,
  'payOut' : () => Promise<string>,
}
