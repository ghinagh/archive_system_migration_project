export interface Person {
  prsNo: string;
  name: string;
  institution: string;
  address: string;
  institutionPhone: string;
  institutionBox: string;
  institutionDirectorate: string;
  institutionEmail: string;
  registrationId: string;
  birthDate: string | null;
  village: string;
  residence: string;
  secondaryAddress: string;
  phone: string;
  email: string;
  poBox: string;
  qualification: string;
  specialtyDate: string | null;
  entity: string;
  denomination: string;
  politicalAffiliation: string;
  socialMedia: string;
  previousJob: string;
  sex: string;
}

export interface PostAssignment {
  serial: string;
  siteDescription: string | null;
  type: number | null;
  startDate: string | null;
  endDate: string | null;
  status: number | null;
  level: string | null;
}

export interface PersonAssignment {
  postSerial: string;
  siteDescription: string | null;
  postType: number | null;
  startDate: string | null;
  endDate: string | null;
  status: number | null;
  level: string | null;
  wilayaNo: number | null;
  positionNo: string | null;
  positionName: string | null;
}

export interface Staff {
  prsNo: string;
  name: string;
  institution: string;
  address: string;
  institutionPhone: string;
  institutionBox: string;
  institutionDirectorate: string;
  institutionEmail: string;
  registrationId: string;
  birthDate: string | null;
  village: string;
  residence: string;
  secondaryAddress: string;
  phone: string;
  email: string;
  poBox: string;
  specialtyTypeCode: number | null;
  qualification: string;
  specialtyDate1: string | null;
  specialtyDate2: string | null;
  entity: string;
}

export interface StaffRequest {
  prsNo: string;
  name: string;
  institution: string;
  address: string;
  institutionPhone: string;
  institutionBox: string;
  institutionDirectorate: string;
  institutionEmail: string;
  registrationId: string;
  birthDate: string | null;
  village: string;
  residence: string;
  secondaryAddress: string;
  phone: string;
  email: string;
  poBox: string;
  specialtyTypeCode: number | null;
  qualification: string;
  specialtyDate1: string | null;
  specialtyDate2: string | null;
  entity: string;
}

export interface PersonRequest {
  prsNo: string;
  name: string;
  institution: string;
  address: string;
  institutionPhone: string;
  institutionBox: string;
  institutionDirectorate: string;
  institutionEmail: string;
  registrationId: string;
  birthDate: string | null;
  village: string;
  residence: string;
  secondaryAddress: string;
  phone: string;
  email: string;
  poBox: string;
  qualification: string;
  specialtyDate: string | null;
  entity: string;
  denomination: string;
  politicalAffiliation: string;
  socialMedia: string;
  previousJob: string;
  sex: string;
}
