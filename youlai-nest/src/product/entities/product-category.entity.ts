import { Column, Entity } from "typeorm";
import { BaseEntity } from "../../common/entities/base.entity";

@Entity("product_category")
export class ProductCategory extends BaseEntity {
  @Column({ name: "parent_id", type: "int", default: 0, comment: "父分类 ID" })
  parentId: number;

  @Column({ type: "int", default: 100, comment: "排序" })
  sort: number;

  @Column({ type: "tinyint", default: 1, comment: "状态 (1=启用)" })
  status: number;

  // 显式声明 id 属性以确保 TypeScript 识别
  id: number;
}
