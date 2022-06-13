import { RowDataPacket } from 'mysql2';

export default interface ICommunication extends RowDataPacket {
  id: number;
  object: string;
  content: string;
  isOpened: boolean;
  idAdmin: number;
  idCommunicationMember: number;
  isBanner: boolean;
}
