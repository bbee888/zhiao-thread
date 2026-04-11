import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { Inquiry } from "./entities/inquiry.entity";
import { CreateInquiryDto } from "./dto/create-inquiry.dto";
import { InquiryQueryDto } from "./dto/inquiry-query.dto";

@Injectable()
export class InquiryService {
  constructor(
    @InjectRepository(Inquiry)
    private readonly inquiryRepository: Repository<Inquiry>
  ) {}

  async create(dto: CreateInquiryDto, meta?: { ip?: string; userAgent?: string }) {
    const entity = this.inquiryRepository.create({
      ...dto,
      status: 0,
      ip: meta?.ip,
      userAgent: meta?.userAgent,
    });
    await this.inquiryRepository.save(entity);
    return true;
  }

  async findPage(query: InquiryQueryDto) {
    const page = Number(query.page || 1);
    const limit = Number(query.limit || 10);
    const keywords = (query.keywords || "").trim();

    const qb = this.inquiryRepository
      .createQueryBuilder("i")
      .where("i.isDeleted = :isDeleted", { isDeleted: 0 });

    if (Number.isFinite(query.status)) {
      qb.andWhere("i.status = :status", { status: query.status });
    }

    if (keywords) {
      qb.andWhere(
        "(i.name LIKE :kw OR i.email LIKE :kw OR i.company LIKE :kw OR i.subject LIKE :kw)",
        { kw: `%${keywords}%` }
      );
    }

    qb.orderBy("i.createTime", "DESC")
      .skip((page - 1) * limit)
      .take(limit);

    const [items, total] = await qb.getManyAndCount();
    return { items, total };
  }

  async findOne(id: string) {
    const inquiryId = Number(id);
    return await this.inquiryRepository.findOne({
      where: { id: inquiryId, isDeleted: 0 },
    });
  }

  async updateStatus(id: string, status: number) {
    await this.inquiryRepository.update(Number(id), {
      status,
      updateTime: new Date(),
    } as any);
    return true;
  }

  async delete(id: string) {
    await this.inquiryRepository.update(Number(id), {
      isDeleted: 1,
      updateTime: new Date(),
    } as any);
    return true;
  }
}
