export interface CatalogueItem {
  appNo: string;
  activeTitleAr: string;
  additionalTitle: string;
  dataEntry: string;
  appDoc: string;
  entryDate: string;
  writeDate: string;
  appRevision: string;
  type: string;
  result: string;
  trans: number;
}

export interface CatalogueFormData {
  appNo: string;
  activeTitleAr: string;
  additionalTitle: string;
  dataEntry: string;
  appDoc: string;
  entryDate: string;
  writeDate: string;
  appRevision: string;
  type: string;
  result: string;
  trans: number;
}

export interface NarowerTerm {
  id: number;
  appNo: string;
  descriptorNo: string;
  serialNo: string;
  relativeNo: string;
  narrowerType: string;
  narrowerNo: string;
}

export interface NarowerRequest {
  descriptorNo: string;
  serialNo: string;
  relativeNo?: string;
  narrowerType: string;
  narrowerNo: string;
}

export interface RelatedTerm {
  id: number;
  appNo: string;
  descriptorNo: string;
  serialNo: string;
  relativeNo: string;
  relativeType: string;
  relationNo: string;
}

export interface RelatedRequest {
  descriptorNo: string;
  serialNo: string;
  relativeNo?: string;
  relativeType: string;
  relationNo: string;
}

/** ANALIS — the document's assigned MACNZ descriptors (Form2.frm's DBList1, code 10). */
export interface SubjectDescriptor {
  id: number;
  appNo: string;
  descriptorNo: string;
  serialNo: string;
}

export interface SubjectDescriptorRequest {
  descriptorNo: string;
  serialNo: string;
}

/** GEO — geographic terms attached to one assigned descriptor (Form2.frm's DBList2, code 20). */
export interface GeoDescriptor {
  id: number;
  appNo: string;
  descriptorNo: string;
  serialNo: string;
  geoNo: string;
}

export interface GeoDescriptorRequest {
  descriptorNo: string;
  serialNo: string;
  geoNo: string;
}

/**
 * FILE_ADD — "additional file" cross-references (Form2.frm's DBList9/10 codes 03/04,
 * and DBList7/8 codes 50/60 when fileType1="2" scopes it to one relation number).
 */
export interface FileAddItem {
  id: string;
  appNo: string;
  descriptorNo: string;
  serialNo: string;
  fileType1: string;
  fileType2: string;
  relativeNo: string | null;
  fileNo: string;
}

export interface FileAddRequest {
  descriptorNo: string;
  serialNo: string;
  fileType1: string;
  fileType2: string;
  relativeNo?: string;
  fileNo: string;
}

/**
 * TIME — a relation's start/end playback timecode (Form2.frm's in/out buttons,
 * Command26/Command25). No media player in the new app; entered manually here.
 */
export interface TimeDescriptor {
  appNo: string;
  serNo: string;
  rltvNo: string;
  descNo: string | null;
  startHour: number | null;
  startMinute: number | null;
  startSecond: number | null;
  endHour: number | null;
  endMinute: number | null;
  endSecond: number | null;
}

export interface TimeDescriptorRequest {
  tmSerNo: string;
  tmRltvNo: string;
  tmDescNo?: string;
  tmO?: number;
  tmM?: number;
  tmS?: number;
  tmO1?: number;
  tmM1?: number;
  tmS1?: number;
}

export interface CatalogueLinkedAuthor {
  id: number;
  appNo: string;
  resourceType: string;
  resourceTypeDescription: string | null;
  authorNo: number;
  authorName: string;
}

export interface LinkedAuthorRequest {
  resourceType: string;
  authorNo: number;
}

export interface DateSubject {
  appNo: string;
  dteSerNo: string;
  dteRelNo: string;
  dteDescNo: string | null;
  dteDteDeb: string | null;
  dteDteFin: string | null;
}

export interface DateSubjectRequest {
  dteSerNo: string;
  dteRelNo: string;
  dteDescNo?: string;
  dteDteDeb?: string;
  dteDteFin?: string;
}

export interface Text1Item {
  appNo: string;
  txtSerNo: string;
  txtDescN: string | null;
  txtRltvN: string | null;
  txtRltvTyp: string | null;
  txtText: string | null;
  txtNbpage: number | null;
}

export interface Text1Request {
  txtSerNo: string;
  txtDescN?: string;
  txtRltvN?: string;
  txtRltvTyp?: string;
  txtText?: string;
  txtNbpage?: number;
}

export interface TempFile {
  tmpFadNo: string;
  tmpSer: number;
  tmpFileName: string | null;
  tmpRmrk: string | null;
  tmpMk: string | null;
  tmpDate: string | null;
  tmpUserNo: string | null;
  userName: string | null;
  tmpFinal: number;
}

export interface TempFileRequest {
  tmpFadNo: string;
  tmpFileName?: string;
  tmpRmrk?: string;
  tmpMk?: string;
  tmpDate?: string;
}

export interface Main2Item {
  appNo: string;
  activeTitleAr: string | null;
  activeCode: string | null;
  additionalTitle: string | null;
  additionalCode: string | null;
  dataEntry: string | null;
  appDoc: string | null;
  entryDate: string | null;
  writeDate: string | null;
  appRevision: string | null;
  chartNo: string | null;
  startHours: number | null;
  startMinutes: number | null;
  startSeconds: number | null;
  endHours: number | null;
  endMinutes: number | null;
  endSeconds: number | null;
  size: number | null;
  type: string | null;
  pictureCode: string | null;
  voiceCode: string | null;
  result: string | null;
}

export interface CorrectionLog {
  id: string;
  appNo: string;
  correctedAt: string;
  correctedByUser: string;
  fieldName: string;
  oldValue: string | null;
  newValue: string | null;
  correctionReason: string | null;
}

export interface Main2Request {
  chartNo?: string | null;
  startHours?: number | null;
  startMinutes?: number | null;
  startSeconds?: number | null;
  endHours?: number | null;
  endMinutes?: number | null;
  endSeconds?: number | null;
  size?: number | null;
  type?: string | null;
  pictureCode?: string | null;
  voiceCode?: string | null;
  result?: string | null;
}
