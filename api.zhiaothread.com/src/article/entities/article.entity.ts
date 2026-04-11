import { Column, Entity } from "typeorm";
import { BaseEntity } from "../../common/entities/base.entity";

@Entity("article")
export class Article extends BaseEntity {
  @Column({ name: "cate_id", type: "int", comment: "分类 ID" })
  cateId: number;

  @Column({ type: "varchar", length: 255, default: "", comment: "封面图" })
  cover: string;

  @Column({ type: "int", default: 100, comment: "排序" })
  sort: number;

  @Column({ type: "tinyint", default: 1, comment: "状态 (1=发布 0=隐藏)" })
  status: number;

  // 显式声明 id 属性以确保 TypeScript 识别
  id: number;
}
