import { Column, Entity, ManyToOne, JoinColumn, Unique } from "typeorm";
import { BaseEntity } from "../../common/entities/base.entity";
import { Product } from "./product.entity";

@Entity("product_lang")
@Unique(["productId", "lang"])
export class ProductLang extends BaseEntity {
  @Column({ name: "product_id", type: "int", comment: "产品 ID" })
  productId: number;

  @Column({ type: "varchar", length: 10, comment: "语言 en/ar/th/ms/id/vi/fr/it/km" })
  lang: string;

  @Column({ name: "title", type: "varchar", length: 255, comment: "产品标题" })
  title: string;

  @Column({ name: "content", type: "longtext", nullable: true, comment: "详情内容" })
  content: string;

  @Column({ name: "keywords", type: "varchar", length: 255, default: "", comment: "SEO 关键词" })
  keywords: string;

  @Column({ name: "description", type: "varchar", length: 500, default: "", comment: "SEO 描述" })
  description: string;

  @ManyToOne(() => Product)
  @JoinColumn({ name: "product_id" })
  product: Product;
}
