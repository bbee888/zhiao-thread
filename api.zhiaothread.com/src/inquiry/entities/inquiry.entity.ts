import { Column, Entity } from "typeorm";
import { BaseEntity } from "src/common/entities/base.entity";

@Entity("inquiry")
export class Inquiry extends BaseEntity {
  @Column({ type: "varchar", length: 50, comment: "姓名" })
  name: string;

  @Column({ type: "varchar", length: 100, comment: "邮箱" })
  email: string;

  @Column({ type: "varchar", length: 100, nullable: true, comment: "公司名称" })
  company?: string;

  @Column({ type: "varchar", length: 50, nullable: true, comment: "电话/微信" })
  phone?: string;

  @Column({ type: "varchar", length: 10, comment: "国家/地区" })
  country: string;

  @Column({ type: "varchar", length: 50, nullable: true, comment: "感兴趣的产品" })
  interest?: string;

  @Column({ type: "varchar", length: 200, comment: "主题" })
  subject: string;

  @Column({ type: "text", comment: "留言内容" })
  message: string;

  @Column({
    name: "attachment_name",
    type: "varchar",
    length: 255,
    nullable: true,
    comment: "附件名称",
  })
  attachmentName?: string;

  @Column({
    name: "attachment_url",
    type: "varchar",
    length: 1024,
    nullable: true,
    comment: "附件URL",
  })
  attachmentUrl?: string;

  @Column({ type: "tinyint", default: 0, comment: "状态（0-未处理 1-已处理）" })
  status: number;

  @Column({ type: "varchar", length: 10, nullable: true, comment: "提交语言" })
  locale?: string;

  @Column({ type: "varchar", length: 45, nullable: true, comment: "IP" })
  ip?: string;

  @Column({
    name: "user_agent",
    type: "varchar",
    length: 255,
    nullable: true,
    comment: "User-Agent",
  })
  userAgent?: string;

  @Column({ type: "varchar", length: 50, nullable: true, comment: "型号" })
  model?: string;

  @Column({ type: "varchar", length: 100, nullable: true, comment: "数量" })
  quantity?: string;

  @Column({ type: "varchar", length: 50, nullable: true, comment: "颜色" })
  color?: string;

  @Column({ type: "varchar", length: 50, nullable: true, comment: "长度" })
  length?: string;

  @Column({ type: "varchar", length: 50, nullable: true, comment: "强度" })
  tenacity?: string;

  @Column({ name: "product_id", type: "bigint", nullable: true, comment: "关联产品ID" })
  productId?: number;
}
