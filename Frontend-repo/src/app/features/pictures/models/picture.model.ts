export interface MediaResolveInfo {
  resolvedPath: string;
  fileExists: boolean;
}

export interface Picture {
  picNo: string;
  picNgNo: string;
  picPosNo: string;
  picDoc: string;
  picDocDte: string | null;
  picEnt: string;
  picEntDte: string | null;
  picPrs: string;
  picDte: string | null;
  picTit: string;
  picCot: string;
  picGeo: string;
  picTyp: number | null;
  picForm: number | null;
  picLen: number | null;
  picLarge: number | null;
  picQualty: number | null;
  picSub: number | null;
  picRmrk: string;
  picCopy: number | null;
  picLbn: string;
  picPage: string;
  picLine: string;
  picTyp1: number | null;
  picBrind: number | null;
  picChoice: number | null;
}

export interface PictureRequest {
  picNo: string;
  picNgNo: string;
  picPosNo: string;
  picDoc: string;
  picDocDte: string | null;
  picEnt: string;
  picEntDte: string | null;
  picPrs: string;
  picDte: string | null;
  picTit: string;
  picCot: string;
  picGeo: string;
  picTyp: number | null;
  picForm: number | null;
  picLen: number | null;
  picLarge: number | null;
  picQualty: number | null;
  picSub: number | null;
  picRmrk: string;
  picCopy: number | null;
  picLbn: string;
  picPage: string;
  picLine: string;
  picTyp1: number | null;
  picBrind: number | null;
  picChoice: number | null;
}
