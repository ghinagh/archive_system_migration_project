export interface Book {
  appNo: string;
  catalogueTitle: string;
  publishLocation: string;
  publisher: number | null;
  publishType: string;
  selectNo: string;
  publishDate: string | null;
  materialCount: string;
  lang3: string;
  edition: number | null;
  rdmk: string;
  cover: string;
  pageCount: number | null;
  partNo: number | null;
  isSeries: boolean;
  copyCount: number | null;
  regNo: number | null;
  additionalTitle: string;
  khalif: string;
  volume: number | null;
  documentType: string;
  quarter: string;
  save: number | null;
  price: number | null;
  acquisitionDate: string | null;
  translator: number | null;
  seriesTitle: string;
  seriesNo: number | null;
  lang1: string;
  volume1: number | null;
  bindingFrom: number | null;
  bindingTo: number | null;
  partFrom: number | null;
  partTo: number | null;
  content: string;
  memo: string;
  yearPublished: number | null;
  yearType: number | null;
  result: string;
  free: number | null;
  lang: string;
  borrowingNo: string;
  status: string;
}

export interface BookRequest {
  appNo: string;
  activeTitleAr: string;
  additionalCatalogueTitle: string;
  publishLocation: string;
  publisher: number | null;
  publishType: string;
  selectNo: string;
  publishDate: string | null;
  materialCount: string;
  lang3: string;
  edition: number | null;
  rdmk: string;
  cover: string;
  pageCount: number | null;
  partNo: number | null;
  isSeries: boolean;
  copyCount: number | null;
  regNo: number | null;
  additionalTitle: string;
  khalif: string;
  volume: number | null;
  documentType: string;
  quarter: string;
  save: number | null;
  price: number | null;
  acquisitionDate: string | null;
  translator: number | null;
  seriesTitle: string;
  seriesNo: number | null;
  lang1: string;
  volume1: number | null;
  bindingFrom: number | null;
  bindingTo: number | null;
  partFrom: number | null;
  partTo: number | null;
  content: string;
  memo: string;
  yearPublished: number | null;
  yearType: number | null;
  result: string;
  free: number | null;
  lang: string;
  borrowingNo: string;
  status: string;
}

export interface BookAuthor {
  authorId: number;
  authorName: string;
  role: string;
}

export interface BookSubject {
  subjectCode: string;
  subjectName: string;
  level: number;
}

export interface BookDescriptor {
  type: string;
  value: string;
}

export interface BookSeries {
  appNo: string;
  arabicSeriesTitle: string;
  additionalTitle: string;
  activeNo: number | null;
  additionalNo: number | null;
}

export interface BookLinkedAuthor {
  id: number;
  appNo: string;
  resourceType: string;
  authorNo: number;
  authorName: string;
}
