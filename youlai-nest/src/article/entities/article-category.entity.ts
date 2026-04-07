import { Column, Entity } from "typeorm";
import { BaseEntity } from "../../common/entities/base.entity";

@Entity("article_category")
export class ArticleCategory extends BaseEntity {
  @Column({ type: "int", default: 100, comment: "排序" })
  sort: number;

  @Column({ type: "tinyint", default: 1, comment: "状态 (1=启用)" })
  status: number;

  // 显式声明 id 属性以确保 TypeScript 识别
  id: number;
}
