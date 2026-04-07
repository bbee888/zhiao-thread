import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Body,
  Param,
  Query,
  ParseIntPipe,
} from "@nestjs/common";
import { CompanyService } from "./company.service";
import { CreateCompanyDto } from "./dto/create-company.dto";
import { UpdateCompanyDto } from "./dto/update-company.dto";
import { ApiOperation, ApiTags } from "@nestjs/swagger";
import { Public } from "../common/decorators/public.decorator";

@ApiTags("公司管理")
@Controller("company")
export class CompanyController {
  constructor(private readonly companyService: CompanyService) {}

  @ApiOperation({ summary: "查询公司介绍列表（分页）" })
  @Public()
  @Get("page")
  async findCompanies(
    @Query("pageNum", new ParseIntPipe({ optional: true })) pageNum: number = 1,
    @Query("pageSize", new ParseIntPipe({ optional: true })) pageSize: number = 10,
    @Query("keyword") keyword?: string,
    @Query("status", new ParseIntPipe({ optional: true })) status?: number
  ) {
    return this.companyService.findCompanies(pageNum, pageSize, keyword, status);
  }

  @ApiOperation({ summary: "获取公司表单数据" })
  @Get(":id")
  async getCompanyForm(@Param("id", ParseIntPipe) id: number) {
    return this.companyService.getCompanyForm(id);
  }

  @ApiOperation({ summary: "创建公司介绍" })
  @Post()
  async createCompany(@Body() createCompanyDto: CreateCompanyDto) {
    return this.companyService.createCompany(createCompanyDto);
  }

  @ApiOperation({ summary: "更新公司介绍" })
  @Put(":id")
  async updateCompany(
    @Param("id", ParseIntPipe) id: number,
    @Body() updateCompanyDto: UpdateCompanyDto
  ) {
    return this.companyService.updateCompany(id, updateCompanyDto);
  }

  @ApiOperation({ summary: "删除公司介绍" })
  @Delete(":ids")
  async deleteCompanies(@Param("ids") ids: string) {
    const idArray = ids.split(",").map((id) => Number(id));
    return this.companyService.deleteCompanies(idArray);
  }
}
