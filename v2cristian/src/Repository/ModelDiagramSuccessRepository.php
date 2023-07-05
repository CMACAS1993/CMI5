<?php

namespace App\Repository;

use App\Entity\ModelDiagramSuccess;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<ModelDiagramSuccess>
 *
 * @method ModelDiagramSuccess|null find($id, $lockMode = null, $lockVersion = null)
 * @method ModelDiagramSuccess|null findOneBy(array $criteria, array $orderBy = null)
 * @method ModelDiagramSuccess[]    findAll()
 * @method ModelDiagramSuccess[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ModelDiagramSuccessRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ModelDiagramSuccess::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(ModelDiagramSuccess $entity, bool $flush = true): void
    {
        $this->_em->persist($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function remove(ModelDiagramSuccess $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    // /**
    //  * @return ModelDiagramSuccess[] Returns an array of ModelDiagramSuccess objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('m')
            ->andWhere('m.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('m.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?ModelDiagramSuccess
    {
        return $this->createQueryBuilder('m')
            ->andWhere('m.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
