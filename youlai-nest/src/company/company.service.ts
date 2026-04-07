import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository, In } from "typeorm";
import { Company } from "./entities/company.entity";
import { CompanyLang } from "./entities/company-lang.entity";
import { CreateCompanyDto, CompanyLangData } from "./dto/create-company.dto";
import { UpdateCompanyDto } from "./dto/update-company.dto";

@Injectable()
export class CompanyService {
  constructor(
    @InjectRepository(Company)
    private readonly companyRepository: Repository<Company>,
    @InjectRepository(CompanyLang)
    private readonly companyLangRepository: Repository<CompanyLang>
  ) {}

  /**
   * 查询公司介绍列表（分页）
   */
  async findCompanies(page: number = 1, limit: number = 10, keyword?: string, status?: number) {
    const queryBuilder = this.companyRepository.createQueryBuilder("company");
    queryBuilder.where("company.isDeleted = :isDeleted", { isDeleted: 0 });

    if (keyword) {
      // 通过多语言表搜索标题
      const langIds = await this.companyLangRepository
        .createQueryBuilder("lang")
        .select("lang.companyId")
        .where("lang.title LIKE :keyword", { keyword: `%${keyword}%` })
        .getRawMany();

      if (langIds.length > 0) {
        const companyIds = langIds.map((item) => item.companyId);
        queryBuilder.andWhere("company.id IN (:...companyIds)", { companyIds });
      } else {
        queryBuilder.andWhere("1=0");
      }
    }

    if (status !== undefined && status !== null) {
      queryBuilder.andWhere("company.status = :status", { status });
    }

    queryBuilder.orderBy("company.sort", "ASC").addOrderBy("company.createTime", "DESC");

    const [items, total] = await queryBuilder
      .skip((page - 1) * limit)
      .take(limit)
      .getManyAndCount();

    // 获取每个项的多语言数据（默认中文，用于列表展示）
    const itemsWithLang = await Promise.all(
      items.map(async (item) => {
        const langInfo = await this.companyLangRepository.findOne({
          where: { companyId: item.id, lang: "zh" },
        });
        return {
          ...item,
          title: langInfo?.title || "",
        };
      })
    );

    return { items: itemsWithLang, total };
  }

  /**
   * 获取表单数据（包含所有多语言）
   */
  async getCompanyForm(id: string | number) {
    const idNum = Number(id);
    const company = await this.companyRepository.findOne({
      where: { id: idNum, isDeleted: 0 },
    });

    if (!company) {
      throw new NotFoundException("数据不存在");
    }

    const langDataList = await this.companyLangRepository.find({
      where: { companyId: idNum },
    });

    const langData: Record<string, CompanyLangData> = {};
    langDataList.forEach((item) => {
      langData[item.lang] = {
        title: item.title,
        content: item.content,
        seoTitle: item.seoTitle,
        seoKeywords: item.seoKeywords,
        seoDescription: item.seoDescription,
      };
    });

    return {
      ...company,
      langData,
    };
  }

  /**
   * 创建公司介绍
   */
  async createCompany(createCompanyDto: CreateCompanyDto) {
    const company = this.companyRepository.create({
      logo: createCompanyDto.logo || "",
      cover: createCompanyDto.cover || "",
      sort: createCompanyDto.sort || 100,
      status: createCompanyDto.status ?? 1,
    });

    const savedCompany = await this.companyRepository.save(company);

    if (createCompanyDto.langData) {
      await this.saveLangData(savedCompany.id, createCompanyDto.langData);
    }

    return savedCompany;
  }

  /**
   * 更新公司介绍
   */
  async updateCompany(id: string | number, updateCompanyDto: UpdateCompanyDto) {
    const idNum = Number(id);
    const company = await this.companyRepository.findOne({
      where: { id: idNum, isDeleted: 0 },
    });

    if (!company) {
      throw new NotFoundException("数据不存在");
    }

    await this.companyRepository.update(idNum, {
      logo: updateCompanyDto.logo,
      cover: updateCompanyDto.cover,
      sort: updateCompanyDto.sort,
      status: updateCompanyDto.status,
    });

    if (updateCompanyDto.langData) {
      await this.saveLangData(idNum, updateCompanyDto.langData);
    }

    return await this.getCompanyForm(idNum);
  }

  /**
   * 删除公司介绍
   */
  async deleteCompanies(ids: (string | number)[]) {
    const idNums = ids.map((id) => Number(id));
    await this.companyRepository.update(idNums, { isDeleted: 1 });
    // 多语言数据可以保留或逻辑删除，这里根据业务决定
    await this.companyLangRepository.update({ companyId: In(idNums) }, { isDeleted: 1 });
  }

  /**
   * 保存多语言数据
   */
  private async saveLangData(companyId: number, langData: Record<string, CompanyLangData>) {
    // 过滤掉完全为空的语言数据
    const validLangs = Object.entries(langData).filter(([_, data]) => data.title || data.content);

    if (validLangs.length === 0) return;

    // 先删除旧数据（物理删除或逻辑删除，这里采用先物理删除再重新插入的方式，简化逻辑）
    await this.companyLangRepository.delete({ companyId });

    const entities = validLangs.map(([lang, data]) =>
      this.companyLangRepository.create({
        companyId,
        lang,
        ...data,
      })
    );

    await this.companyLangRepository.save(entities);
  }
}
