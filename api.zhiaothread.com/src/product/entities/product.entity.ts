import { Column, Entity } from "typeorm";
import { BaseEntity } from "../../common/entities/base.entity";

@Entity("product")
export class Product extends BaseEntity {
  @Column({ name: "cate_id", type: "int", comment: "分类 ID" })
  cateId: number;

  @Column({ type: "varchar", length: 255, default: "", comment: "主图" })
  cover: string;

  @Column({ type: "decimal", precision: 10, scale: 2, default: "0.00", comment: "价格" })
  price: number;

  @Column({ type: "varchar", length: 100, default: "", comment: "型号" })
  model: string;

  @Column({ type: "varchar", length: 50, default: "", comment: "颜色" })
  color: string;

  @Column({ type: "varchar", length: 50, default: "", comment: "长度" })
  length: string;

  @Column({ type: "varchar", length: 50, default: "", comment: "强力" })
  tenacity: string;

  @Column({ type: "int", default: 100, comment: "排序" })
  sort: number;

  @Column({ type: "tinyint", default: 1, comment: "状态 (1=上架 0=下架)" })
  status: number;
}
