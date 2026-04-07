import { Column, Entity, ManyToOne, JoinColumn, Unique } from "typeorm";
import { BaseEntity } from "../../common/entities/base.entity";
import { Company } from "./company.entity";

@Entity("company_lang")
@Unique(["companyId", "lang"])
export class CompanyLang extends BaseEntity {
  @Column({ name: "company_id", type: "int", comment: "关联 company.id" })
  companyId: number;

  @Column({ type: "varchar", length: 10, comment: "语言 en/ar/th/ms/id" })
  lang: string;

  @Column({ name: "title", type: "varchar", length: 255, comment: "标题（如 About Us）" })
  title: string;

  @Column({ name: "content", type: "longtext", nullable: true, comment: "公司介绍内容" })
  content: string;

  @Column({ name: "seo_title", type: "varchar", length: 255, default: "", comment: "SEO 标题" })
  seoTitle: string;

  @Column({ name: "seo_keywords", type: "varchar", length: 255, default: "", comment: "SEO 关键词" })
  seoKeywords: string;

  @Column({ name: "seo_description", type: "varchar", length: 500, default: "", comment: "SEO 描述" })
  seoDescription: string;

  @ManyToOne(() => Company)
  @JoinColumn({ name: "company_id" })
  company: Company;
}
